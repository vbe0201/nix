{
  config,
  lib,
  ...
}:
with lib; {
  options.mine.locale = {
    enable = mkEnableOption "default locale settings";
  };

  config = mkIf config.mine.locale.enable {
    time = {
      timeZone = "Europe/Berlin";
      hardwareClockInLocalTime = true;
    };

    i18n = let
      locale = "de_DE.UTF-8";
    in {
      defaultLocale = locale;
      extraLocaleSettings = {
        LC_ADDRESS = locale;
        LC_IDENTIFICATION = locale;
        LC_MEASUREMENT = locale;
        LC_MONETARY = locale;
        LC_NAME = locale;
        LC_NUMERIC = locale;
        LC_PAPER = locale;
        LC_TELEPHONE = locale;
        LC_TIME = locale;
      };
    };

    console = {
      font = "Lat2-Terminus16";
      keyMap = "us";
    };
  };
}
