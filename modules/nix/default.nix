{
  config,
  lib,
  outputs,
  pkgs,
  ...
}:
with lib; let
  inherit (outputs) overlays;
in {
  options.mine.nix = {
    nix-ld.enable = mkEnableOption "nix-ld system support";

    devShellCleanup = {
      enable = mkEnableOption "Remove stale direnv/devenv GC roots before each GC";

      user = mkOption {
        type = types.str;
        default = "vale";
        description = "User that owns the searched directories and runs the cleanup";
      };

      directories = mkOption {
        type = types.listOf types.str;
        default = let
          inherit (config.mine.nix.devShellCleanup) user;
          home = config.users.users.${user}.home;
        in ["${home}/Coding"];
        defaultText = literalExpression ''
          [
            "''${config.users.users.''${config.mine.nix.devShellCleanup.user}.home}/Coding"
          ]
        '';
        description = "Directories to search for stale .direnv and .devenv/gc folders";
      };

      olderThanDays = mkOption {
        type = types.ints.positive;
        default = 14;
        description = "Only remove folders that have not been modified for this many days";
      };
    };
  };

  config = mkMerge [
    {
      # Set up nixpkgs so that we can access unfree packages and also
      # the packages from the nixos-unstable branch.
      nixpkgs = {
        config.allowUnfree = true;
        overlays = [
          overlays.unstable-unfree-packages
        ];
      };

      nix = {
        package = pkgs.lixPackageSets.stable.lix;

        settings = {
          experimental-features = ["nix-command" "flakes"];

          allowed-users = ["root" "@wheel"];
          trusted-users = ["root" "@wheel"];

          auto-optimise-store = true;
          log-lines = 50;

          min-free = 10 * 1024 * 1024 * 1024;
          max-free = 30 * 1024 * 1024 * 1024;

          warn-dirty = false;
        };

        # Configure the garbage collector to clean up weekly.
        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 7d";
        };
      };
    }

    (mkIf config.mine.nix.devShellCleanup.enable (let
      cfg = config.mine.nix.devShellCleanup;

      # nix-direnv and devenv register their shells as GC roots, so every
      # project that was ever entered pins its whole toolchain closure
      # until the folder is gone. Remove the ones that went untouched.
      cleanupScript = pkgs.writeShellApplication {
        name = "dev-shell-cleanup";
        runtimeInputs = with pkgs; [coreutils findutils];
        text = ''
          for dir in ${escapeShellArgs cfg.directories}; do
            [ -d "$dir" ] || continue

            find "$dir" \
              \( -type d \( -name .git -o -name node_modules -o -name target \) -prune \) -o \
              \( -type d \( -name .direnv -o -path '*/.devenv/gc' \) \
                 -mtime +${toString cfg.olderThanDays} -prune -print0 \) |
              while IFS= read -r -d "" stale; do
                echo "Removing $stale"
                rm -rf -- "$stale"
              done
          done
        '';
      };
    in {
      environment.systemPackages = [cleanupScript];

      systemd.services.dev-shell-cleanup = {
        description = "Remove stale direnv/devenv GC roots";
        serviceConfig = {
          Type = "oneshot";
          User = cfg.user;
          ExecStart = getExe cleanupScript;
        };
      };

      systemd.services.nix-gc = {
        wants = ["dev-shell-cleanup.service"];
        after = ["dev-shell-cleanup.service"];
      };
    }))

    (mkIf config.mine.nix.nix-ld.enable {
      programs.nix-ld = {
        enable = true;
        libraries = with pkgs; [
          alsa-lib
          at-spi2-atk
          at-spi2-core
          atk
          cairo
          cups
          curl
          dbus
          expat
          fontconfig
          freetype
          fuse3
          gdk-pixbuf
          glib
          gtk3
          icu
          libGL
          libappindicator-gtk3
          libdrm
          libglvnd
          libnotify
          libpulseaudio
          libunwind
          libusb1
          libuuid
          libxkbcommon
          libxml2
          mesa
          nspr
          nss
          openssl
          pango
          pipewire
          stdenv.cc.cc
          systemd
          vulkan-loader
          libx11
          libxscrnsaver
          libxcomposite
          libxcursor
          libxdamage
          libxext
          libxfixes
          libxi
          libxrandr
          libxrender
          libxtst
          libxcb
          libxkbfile
          libxshmfence
          zlib
        ];
      };
    })
  ];
}
