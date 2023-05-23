{ pkgs, ... }: {
  home.packages = with pkgs; [libnotify];

  programs.mako = {
    enable = true;

    # TODO: More config.
  };
}
