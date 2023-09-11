{ config, pkgs, ... }: {
  wsl = {
    enable = true;

    wslConf.automount.root = "/mnt";
    defaultUser = "vale";
    startMenuLaunchers = true;

    docker-native.enable = true;
    docker-desktop.enable = true;
  };

  networking = {
    hostName = "spectre";
  };
}
