{
  description = "Configurations for my NixOS system";

  inputs = {
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ { self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit self inputs; } {
      imports = [
        ./systems
      ];

      systems = ["x86_64-linux"];
    };
}
