{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.mine.hardware.udev = {
    switchRcm.enable = mkEnableOption "USB access to Nintendo Switch in RCM mode";
  };

  config = let
    rulesPath = "/lib/udev/rules.d";
    mkSubsystem = system: ''SUBSYSTEM=="${system}"'';
    mkVendorId = vendor: ''ATTRS{idVendor}=="${vendor}"'';
    mkProductId = product: ''ATTRS{idProduct}=="${product}"'';
    mode = ''MODE="0666"'';
  in
    mkMerge [
      {}

      (mkIf config.mine.hardware.udev.switchRcm.enable {
        services.udev.packages = [
          (pkgs.writeTextFile rec {
            name = "50-nintendo-switch-rcm.rules";
            text = ''
              ${mkSubsystem "usb"}, ${mkVendorId "0955"}, ${mkProductId "7321"}, ${mode}
            '';
            destination = "${rulesPath}/${name}";
          })
        ];
      })
    ];
}
