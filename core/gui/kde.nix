## Sets up a global installation of the KDE Plasma 5 environment.
##
## This module is intended for X11-based systems. Further tweaks
## will be required to make it play nicely with Wayland.
{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    xdg-utils
  ];

  programs.dconf.enable = true;

  services.xserver = {
    enable = true;

    desktopManager.plasma5 = {
      enable = true;
      excludePackages = with pkgs.libsForQt5; [
        khelpcenter
        konsole
      ];
    };

    displayManager.sddm.enable = true;
  };

  services.printing.enable = true;

  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
  };

  xdg.portal.enable = true;
}
