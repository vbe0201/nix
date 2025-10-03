{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.mine.gaming = {
    enable = mkEnableOption "gaming support";
  };

  config = mkIf config.mine.gaming.enable {
    programs.steam = {
      enable = true;
      protontricks.enable = true;
    };

    environment.systemPackages = with pkgs; [
      protonup-qt
      unstable.wineWowPackages.unstableFull
      lutris
      bottles
      heroic
    ];
  };
}
