{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.mine.apps.games = {
    enable = mkEnableOption "gaming software";
  };

  config = mkIf config.mine.apps.games.enable {
    home.packages = with pkgs; [
      unstable.dolphin-emu
      melonds
      mame
      pcsx2
      mupen64plus
    ];
  };
}
