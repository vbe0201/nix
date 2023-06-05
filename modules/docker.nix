{ ... }: {
  # Rootless Docker setup for the user.
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
}
