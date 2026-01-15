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
        yubioath-flutter
      ];

    services = {
      pcscd.enable = true;
      udev.packages = with pkgs; [yubikey-personalization];
    };

    security.pam = {
      u2f = {
        enable = true;
        settings = {
          origin = "pam://yubi";
          authfile = pkgs.writeText "u2f-mappings" (lib.concatStrings [
            "vale"
            ":QeXsm34JLxInTNSlFwWjy0cK2qgxIlEcmShCMRPTJe5EsoHrsNHEJQVCaPOskfiOEJmw+kWMK6wqKtDJeSYtdw==,BJG4r9FcNXTA3XDThgOCsw13v0EzOPTdApRnugPwK1LpweNZZQcT5cIRKy9HCOlyDpxKOwvMYi/YEDjkLZSd0Q==,es256,+presence"
          ]);
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
