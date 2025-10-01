{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.mine.apps.creative = {
    enable = mkEnableOption "creative software";
  };

  config = mkIf config.mine.apps.creative.enable {
    home.packages = with pkgs; [
      obs-studio
      v4l-utils
      gimp
      krita
      inkscape
    ];
  };
}
