{
  config,
  pkgs,
  lib,
  ...
}:
with lib; {
  options.mine.yubikey = {
    enable = mkEnableOption "YubiKey support";
  };

  config = mkIf config.mine.yubikey.enable {
    environment.systemPackages = with pkgs;
      [
        yubico-piv-tool
        yubikey-manager
        yubikey-personalization
      ]
      ++ lib.optionals (config.services.xserver.enable) [
        yubikey-personalization-gui
        yubioath-flutter
      ];

    services = {
      pcscd.enable = true;
      udev.packages = with pkgs; [yubikey-personalization];
    };

    # TODO: u2f_keys in config and in a non-default location
    #       https://joinemm.dev/blog/yubikey-nixos-guide
    security.pam = {
      u2f = {
        enable = true;
        settings = {
          interactive = true;
          cue = true;
        };
      };

      services = {
        login.u2fAuth = true;
        sudo.u2fAuth = true;
      };
    };
  };
}
