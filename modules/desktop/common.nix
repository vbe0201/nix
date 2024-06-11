{lib, ...}: {
  services.xserver = {
    enable = true;

    xkb.layout = "eu";

    wacom.enable = lib.mkDefault false;
  };

  services.displayManager.sddm = {
    enable = true;
    autoNumlock = true;
  };

  services.printing.enable = true;
}
