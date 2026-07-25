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
