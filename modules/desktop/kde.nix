{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    xdg-utils
  ];

  programs.dconf.enable = true;

  services.xserver = {
    enable = true;

    layout = "eu";

    desktopManager.plasma5.enable = true;
    displayManager.sddm.enable = true;
  };

  environment.plasma5 = {
    excludePackages = with pkgs.libsForQt5; [
      khelpcenter
      konsole
    ];
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
