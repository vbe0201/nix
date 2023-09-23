{...}: {
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="0955", ATTRS{idProduct}=="7321", MODE="0666"
  '';
}
