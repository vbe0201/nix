{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.mine.openrgb = {
    service.enable = mkEnableOption "OpenRGB background service";
    program.enable = mkEnableOption "OpenRGB desktop application";
  };

  config = mkMerge [
    {}

    (mkIf config.mine.openrgb.service.enable {
      services.hardware.openrgb.enable = true;
    })

    (mkIf config.mine.openrgb.program.enable {
      environment.systemPackages = [
        (pkgs.makeDesktopItem {
          type = "Application";
          name = "OpenRGB";
          desktopName = "OpenRGB";
          comment = "Control RGB lighting";
          icon = "OpenRGB";
          exec = "${pkgs.openrgb}/bin/openrgb";
          terminal = false;
          categories = ["Utility"];
        })
      ];
    })
  ];
}
