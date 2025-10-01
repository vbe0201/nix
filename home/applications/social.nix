{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.mine.apps.social = {
    enable = mkEnableOption "software for these so-called social interactions";
  };

  config = mkIf config.mine.apps.social.enable {
    home.packages = with pkgs; [
      discord
      zoom-us
    ];
  };
}
