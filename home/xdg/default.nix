{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.mine.xdg = {
    enable = mkEnableOption "XDG user directories";
  };

  config = mkIf config.mine.xdg.enable {
    xdg = {
      enable = true;

      configFile."mimeapps.list".force = true;
      mimeApps.enable = true;

      userDirs = {
        enable = true;
        createDirectories = true;
        extraConfig = {
          XDG_SCREENSHOTS_DIR = "$HOME/Pictures/Screenshots";
        };
      };
    };

    home.packages = with pkgs; [xdg-utils];
  };
}
