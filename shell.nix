{
  pkgs ?
    let
      flakeLock = builtins.fromJSON (builtins.readFile ./flake.lock);
      nixpkgsEntry = flakeLock.nodes.nixpkgs.locked;

      nixpkgs = fetchTarball {
        url = "https://github.com/nixos/nixpkgs/archive/${nixpkgsEntry.rev}.tar.gz";
        sha256 = nixpkgsEntry.narHash;
      };

    in import nixpkgs { overlays = []; }
}: {
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes";

    nativeBuildInputs = with pkgs; [
      nix
      home-manager
      git

      gnupg
      rage
      age-plugin-yubikey
    ];
  };
}
