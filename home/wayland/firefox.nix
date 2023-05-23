{ pkgs, ... }: {
  home.sessionVariables.MOZ_ENABLE_WAYLAND = 1;

  home.packages = with pkgs; [firefox-wayland];
}
