{
  description = "Personal NixOS configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devenv = {
      url = "github:cachix/devenv/latest";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... } @ inputs:
    let
      inherit (self) outputs;

      forEachSystem = nixpkgs.lib.genAttrs [
        "x86_64-linux"
      ];

      forEachPkgs = f: forEachSystem (sys: f nixpkgs.legacyPackages.${sys});

    in {
      # Define custom packages for the system.
      packages = forEachPkgs (pkgs:
        (import ./pkgs { inherit pkgs; })
      );

      # A development shell for bootstrapping the flake
      # configuration on a fresh system installation.
      devShells = forEachPkgs (pkgs: import ./shell.nix { inherit pkgs; });

      # Export custom packages and modifications as overlays.
      overlays = import ./overlays { inherit inputs; };

      # Entrypoint to all NixOS systems this config defines.
      nixosConfigurations = import ./hosts { inherit inputs outputs; };
    };
}
