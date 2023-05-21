{ self, inputs, ... }:
  let
    inherit (self) overlays;

    ## Core modules which are crucial for every system go here.
    ## These will be present on every NixOS machine by default.
    coreModules = [
      ../core/locale.nix
      ../core/networking.nix
      ../core/nix-daemon.nix
      ../core/users.nix

      inputs.home-manager.nixosModules.default
    ];

    ## Defines a new NixOS system given the system specifier and
    ## a list of modules which extends upon `coreModules`.
    makeSystem = { system, modules }:
      inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules =
          [
            {
              # Globally configure nixpkgs so that we can get unfree
              # packages on both stable and unstable channels.
              nixpkgs = {
                overlays = [overlays.unstable-unfree-packages];

                config.allowUnfree = true;
              };
            }
          ]
          ++ coreModules
          ++ modules;
      };

  in {
    # For every machine there is a dedicated .nix file which describes
    # hardware  configuration. Don't forget to include in `modules`.

    # My main desktop machine and daily driver. Used for just about anything.
    glacier = makeSystem {
      system = "x86_64-linux";
      modules = [
        ./glacier.nix
      ];
    };
  }
