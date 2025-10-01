{
  config,
  lib,
  ...
}:
with lib; {
  options.mine.localsend = {
    enable = mkEnableOption "LocalSend support";
  };

  config = mkIf config.mine.localsend.enable {
    # LocalSend opens port 53317 in the firewall by default.
    programs.localsend.enable = true;
  };
}
