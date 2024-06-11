{pkgs, ...}: {
  imports = [
    ./common.nix
  ];

  environment.systemPackages = with pkgs; [
    xdg-utils
  ];

  programs.dconf.enable = true;

  services.desktopManager.plasma6.enable = true;

  environment.plasma6 = {
    excludePackages = with pkgs.kdePackages; [
      khelpcenter
      konsole
    ];
  };

  xdg.portal.enable = true;
}
