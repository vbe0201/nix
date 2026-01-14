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
      eduvpn-client
      libreoffice-qt6-fresh
      rustdesk
      thunderbird
      unstable.proton-pass
      unstable.protonmail-bridge-gui
      unstable.protonvpn-gui
      xournalpp
    ];
  };
}
