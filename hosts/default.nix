{
  inputs,
  outputs,
  revision,
  ...
}: let
  ## Defines a new NixOS system.
  ##
  ## - `system` is the platform NixOS is running on.
  ## - `modules` is a list of extra attribute sets with host-exclusive
  ##   configuration. For example, the desired modules from the `mine`
  ##   namespace should be set up from there.
  mkNixosSystem = configPath: let
    config = import configPath;
    system = config.system;
  in
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs outputs system;};

      modules =
        [
          ../modules
          ../secrets

          inputs.agenix.nixosModules.default
          inputs.catppuccin.nixosModules.catppuccin
          inputs.home-manager.nixosModules.default

          {
            system.configurationRevision = revision;

            environment.systemPackages = [
              inputs.agenix.packages.${system}.default
            ];

            home-manager = {
              backupFileExtension = "backup";
              useGlobalPkgs = true;
              useUserPackages = true;

              extraSpecialArgs = {
                inherit inputs outputs system;
              };

              users.vale = {...}: {
                imports =
                  [
                    ../home
                  ]
                  ++ config.home.modules;
              };
            };
          }
        ]
        ++ config.modules;
    };
in {
  glacier = mkNixosSystem ./glacier;

  spin = mkNixosSystem ./spin;
}
