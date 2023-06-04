{ pkgs, ... }: {
  # We need to enable zsh system-wide even when it's managed
  # by home-manager as some files will not be sourced otherwise.
  programs.zsh.enable = true;

  # Configure zsh as the global shell for all users since there's
  # not really a point in using other shells alongside it anyway.
  users.defaultUserShell = pkgs.zsh;
}
