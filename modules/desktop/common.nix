{lib, ...}: {
  services.xserver = {
    enable = true;

    layout = "eu";

    wacom.enable = lib.mkDefault false;
    displayManager.sddm = {
      enable = true;
      autoNumlock = true;
    };
  };

  services.printing.enable = true;
}
