{
  description = "Configurations for my NixOS system";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      inherit (self) outputs;

    in {
      # TODO: packages, devShells

      # Export custom packages and modifications as overlays.
      overlays = import ./overlays { inherit inputs; };

      # TODO: nixosModules, homeManagerModules

      # NixOS configuration entrypoint.
      nixosConfigurations = import ./systems { inherit inputs self; };
    };
}
