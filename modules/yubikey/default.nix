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
            ":R4I5eUXW2jq2sEDJeSGmOIePJPfB8J0p/gnJ453aT+dOWPTvRcxvlyJrNzc7ZMzgVznNIID7t12vCtU128yowA==,FCSZEls7lYCl82BsFQ+9yDc/DLrHB20RgO7rQOIiFdk1gZPSx4qR6EqrAAL4fhleno+6kHzN75M+fhEJl3PXzQ==,es256,+presence"
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
