{ pkgs }:
  let
    manifest = (pkgs.lib.importTOML ./Cargo.toml).package;

  in {
    vix = pkgs.rustPlatform.buildRustPackage {
      pname = manifest.name;
      version = manifest.version;
      cargoLock.lockFile = ./Cargo.lock;
      src = pkgs.lib.cleanSource ./.;
    };
  }
