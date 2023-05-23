{ pkgs, ... }: {
  # TODO: Switch back to Firefox at the end of the month.
  # Blocked on: https://github.com/NVIDIA/egl-wayland/pull/74
  # home.sessionVariables.MOZ_ENABLE_WAYLAND = 1;
  # home.packages = with pkgs; [firefox-wayland];

  home.packages = with pkgs; [google-chrome];
}
