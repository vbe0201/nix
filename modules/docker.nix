{ ... }: {
  # Rootless Docker setup for the user.
  virtualisation = {
    containers.enable = true;
    oci-containers.backend = "docker";
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
      autoPrune.enable = true;
    };
  };

  environment.sessionVariables = {
    # `cross` is a utility for cross-compiling Rust programs.
    # This is needed to make it work with rootless Docker setup.
    CROSS_ROOTLESS_CONTAINER_ENGINE = "1";
  };
}
