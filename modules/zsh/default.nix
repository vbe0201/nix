{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.mine.zsh = {
    enable = mkEnableOption "ZSH as the system shell";
  };

  config = mkIf config.mine.zsh.enable {
    # We need to enable zsh system-wide even when it's managed by
    # home-manager as some files will not be sourced otherwise.
    programs.zsh.enable = true;

    # Configure zsh as the global shell for all users. Not really
    # much point in using anything else when we have it.
    users.defaultUserShell = pkgs.zsh;

    # Enable completions for system packages, e.g. systemd.
    environment.pathsToLink = ["/share/zsh"];
  };
}
