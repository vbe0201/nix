{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.mine.apps.productivity = {
    enable = mkEnableOption "productivity software";
  };

  config = mkIf config.mine.apps.productivity.enable {
    home.packages = with pkgs; [
      libreoffice-qt6-fresh
      thunderbird
      unstable.proton-pass
      unstable.protonmail-bridge-gui
      unstable.protonvpn-gui
      unstable.proton-authenticator
      xournalpp
    ];
  };
}
