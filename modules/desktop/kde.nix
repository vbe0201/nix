{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.mine.desktop.kde = {
    enable = mkEnableOption "KDE desktop environment";
  };

  config = mkIf config.mine.desktop.kde.enable {
    services = {
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        autoNumlock = true;
      };

      desktopManager.plasma6.enable = true;
    };

    programs.dconf.enable = true;

    environment.systemPackages = with pkgs; [
      kdePackages.ark
      kdePackages.bluedevil
      kdePackages.kcalc
      kdePackages.kcharselect
      kdePackages.kclock
      kdePackages.kcolorchooser
      kdePackages.konversation
      kdePackages.ksystemlog
      kdePackages.sddm-kcm
      kdePackages.isoimagewriter
      kdePackages.partitionmanager
      hardinfo2
      wayland-utils
      wl-clipboard
      xclip
    ];

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      khelpcenter
      konsole
      kdepim-runtime
      kmahjongg
      kmines
      kpat
      ksudoku
    ];

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    xdg = {
      mime.enable = true;
      icons.enable = true;
      portal.enable = true;
    };
  };
}
