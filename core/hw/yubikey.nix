{ config, pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [
    yubico-piv-tool
    yubikey-manager
    yubikey-manager-qt
    yubikey-personalization
  ] ++ lib.optionals (config.services.xserver.enable) [
    yubikey-personalization-gui
    yubioath-desktop
  ];

  services = {
    pcscd.enable = true;
    udev.packages = with pkgs; [yubikey-personalization];
  };

  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };
}
