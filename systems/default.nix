{ self, lib, inputs, ... }:
  let
    ## Core modules which are crucial for every system go here.
    ## These will be present on every NixOS machine by default.
    coreModules = [
      ../nixos/locale.nix
      ../nixos/nix-daemon.nix
      ../nixos/users.nix
    ];

    ## Defines a new NixOS system given the system specifier and
    ## a list of modules which extends upon `coreModules`.
    makeSystem = { system, modules }:
      let
        overlay-unstable = final: prev: {
          unstable = import inputs.nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
        };

      in {
        inputs.nixpkgs.lib.nixosSystem {
          inherit system;
          modules =
            [
              ({ config, pkgs, ... }: {
                nixpkgs.overlays = [overlay-unstable];

                _module.args.packages = self.packages."${system}";
                _module.args.inputs = inputs;
                _module.args.system = system;
              })
            ]
            ++ coreModules
            ++ modules;
        };
      };

  in {
    flake.nixosConfigurations = {
      # For every machine there is a dedicated .nix file which describes
      # hardware  configuration. Don't forget to include in `modules`.

      # My main desktop machine and daily driver.
      # Used for just about anything.
      glacier = makeSystem {
        system = "x86_64-linux";
        modules = [
          ./glacier.nix
        ];
      };
    };
  }
