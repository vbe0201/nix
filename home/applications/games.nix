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
      dolphin-emu
      melonDS
      duckstation
      mame
      pcsx2
      mupen64plus
    ];
  };
}
