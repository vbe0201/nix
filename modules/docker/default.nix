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

      # Only run the per-user rootless daemon. The system-wide one
      # stays disabled since access to it is equivalent to root.
      docker.rootless = {
        enable = true;
        setSocketVariable = true;
        daemon.settings = {
          storage-driver = "overlay2";
        };
      };
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
  };
}
