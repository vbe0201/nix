{
  config,
  lib,
  ...
}:
with lib; {
  options.mine.flatpak = {
    enable = mkEnableOption "flatpak support";
  };

  config = mkIf config.mine.flatpak.enable {
    services.flatpak.enable = true;
  };
}
