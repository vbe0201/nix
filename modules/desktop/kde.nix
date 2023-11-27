{pkgs, ...}: {
  imports = [
    ./common.nix
  ];

  environment.systemPackages = with pkgs; [
    xdg-utils
  ];

  programs.dconf.enable = true;

  services.xserver = {
    desktopManager.plasma5.enable = true;
  };

  environment.plasma5 = {
    excludePackages = with pkgs.libsForQt5; [
      khelpcenter
      konsole
    ];
  };

  xdg.portal.enable = true;
}
