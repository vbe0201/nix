{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.mine.docker = {
    enable = mkEnableOption "Docker daemon";
  };

  config = mkIf config.mine.docker.enable {
    virtualisation = {
      containers.enable = true;

      docker = {
        enable = true;
        storageDriver = "overlay2";
        rootless = {
          enable = true;
          setSocketVariable = true;
        };
        autoPrune = {
          enable = true;
          dates = "weekly";
        };
        extraOptions = ''
          --experimental
        '';
      };

      oci-containers.backend = "docker";
    };

    environment.systemPackages = with pkgs; [
      docker-compose
      docker-credential-helpers
    ];

    environment.sessionVariables = {
      # cross is a utility for cross-compiling Rust programs.
      # We need to inform it of the rootless Docker setup or it breaks.
      CROSS_ROOTLESS_CONTAINER_ENGINE = "1";
    };

    users.users.vale.extraGroups = ["docker"];
  };
}
