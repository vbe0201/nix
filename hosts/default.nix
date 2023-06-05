{ inputs, outputs, ... }:
  let
    inherit (builtins) length map;
    inherit (inputs.nixpkgs.lib) optionals flatten;
    inherit (outputs) overlays;

    ## Core modules which are crucial for every system go here.
    ## These will be present on every NixOS machine by default.
    coreModules = [
      ../modules/core
      ../modules/hw/yubikey.nix

      ../secrets

      inputs.agenix.nixosModules.default
      inputs.agenix-rekey.nixosModules.default
      inputs.home-manager.nixosModules.default
    ];

    ## Defines a home-manager module for the `vale` user.
    makeHome = modules: system: {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        extraSpecialArgs = {
          inherit inputs outputs;
        };

        users.vale = { ... }: {
          imports = modules;
          home.stateVersion = "22.11";
        };
      };
    };

    ## Defines a new NixOS system.
    makeSystem = { system, modules, homeModules ? [] }:
      inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs // { inherit system; };
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
            }
          ]
          ++ coreModules
          ++ modules
          ++ (optionals (length homeModules != 0) [(makeHome homeModules system)]);
      };

  in {
    # My main desktop machine and daily driver.
    glacier = makeSystem {
      system = "x86_64-linux";
      modules = [
        ./glacier.nix

        ../modules/docker.nix
        ../modules/desktop/kde.nix
        ../modules/hw/nvidia.nix
        ../modules/vpn/sext.nix
      ];
      homeModules = [
        ../home/alacritty.nix
        ../home/git.nix
        ../home/gpg.nix
        ../home/programs.nix
        ../home/x11
        ../home/zsh.nix

        inputs.nix-index-database.hmModules.nix-index
      ];
    };
  }
