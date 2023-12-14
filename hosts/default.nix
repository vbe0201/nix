{
  inputs,
  outputs,
  ...
}: let
  inherit (builtins) length;
  inherit (inputs.nixpkgs.lib) optionals;
  inherit (outputs) overlays;

  ## Core modules which are crucial for every system go here.
  ## These will be present on every NixOS machine by default.
  coreModules = [
    ../modules/core

    inputs.agenix.nixosModules.default
    inputs.home-manager.nixosModules.default
  ];

  ## Defines a home-manager module for the `vale` user.
  makeHome = isWSL: modules: system: {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      extraSpecialArgs = {
        inherit inputs outputs;
        inherit system;
        inherit isWSL;
      };

      users.vale = {...}: {
        imports = modules;
        home.stateVersion = "22.11";
      };
    };
  };

  ## Defines a new NixOS system.
  makeSystem = {
    system,
    modules,
    isWSL,
    homeModules ? [],
  }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = inputs // {inherit system isWSL;};
      modules =
        [
          {
            # Globally configure nixpkgs so that we can get unfree
            # packages on both stable and unstable channels.
            nixpkgs = {
              hostPlatform = system;
              overlays = [
                inputs.rust-overlay.overlays.default

                overlays.unstable-unfree-packages
              ];
              config.allowUnfree = true;
            };

            # Globally install the `vix` automation utility.
            environment.systemPackages = [
              inputs.agenix.packages.${system}.default
              outputs.packages.${system}.vix
            ];
          }
        ]
        ++ coreModules
        ++ (optionals (!isWSL) [../secrets])
        ++ modules
        ++ (optionals (length homeModules != 0) [(makeHome isWSL homeModules system)]);
    };
in {
  # My main desktop machine and daily driver.
  glacier = makeSystem {
    system = "x86_64-linux";
    modules = [
      ./glacier.nix

      ../modules/core/docker.nix
      ../modules/core/sound.nix

      ../modules/steam.nix
      ../modules/desktop/kde.nix
      ../modules/hw/nvidia.nix
      ../modules/hw/switch.nix
      ../modules/hw/yubikey.nix
      ../modules/vpn/mullvad.nix
      ../modules/vpn/sext.nix
    ];
    isWSL = false;
    homeModules = [
      ../home/x11

      ../home/alacritty.nix
      ../home/firefox.nix
      ../home/git.nix
      ../home/gpg.nix
      ../home/packages
      ../home/vscode.nix
      ../home/xdg.nix
      ../home/zsh.nix

      inputs.nix-index-database.hmModules.nix-index
    ];
  };

  # My notebook for work.
  spin = makeSystem {
    system = "x86_64-linux";
    modules = [
      ./spin.nix

      ../modules/core/bluetooth.nix
      ../modules/core/sound.nix

      ../modules/steam.nix
      ../modules/desktop/kde.nix
      ../modules/hw/switch.nix
      ../modules/hw/yubikey.nix
      ../modules/vpn/mullvad.nix
      ../modules/vpn/sext.nix
    ];
    isWSL = false;
    homeModules = [
      ../home/x11

      ../home/alacritty.nix
      ../home/firefox.nix
      ../home/git.nix
      ../home/gpg.nix
      ../home/packages/apps.nix
      ../home/packages/cli.nix
      ../home/packages/dev.nix
      ../home/packages/media.nix
      ../home/vscode.nix
      ../home/xdg.nix
      ../home/zsh.nix

      inputs.nix-index-database.hmModules.nix-index
    ];
  };
}
