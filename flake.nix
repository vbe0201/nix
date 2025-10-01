{
  description = "Personal NixOS configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix/release-25.05";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;

    forEachSystem = nixpkgs.lib.genAttrs [
      "x86_64-linux"
    ];

    forEachPkgs = f: forEachSystem (system: f nixpkgs.legacyPackages.${system});
  in {
    # Define custom packages for the system.
    packages = forEachPkgs (
      pkgs: (import ./pkgs {inherit pkgs;})
    );

    # A development shell for bootstrapping the flake
    # configuration on a fresh system installation.
    devShells = forEachPkgs (pkgs: import ./shell.nix {inherit pkgs;});

    # Export custom packages and modifications as overlays.
    overlays = import ./overlays {inherit inputs;};

    # Entrypoint to all NixOS systems this config defines.
    nixosConfigurations = import ./hosts {
      inherit inputs outputs;
      revision = self.rev or "dirty";
    };
  };
}
