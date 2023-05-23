{ ... }: {
  # This enables Wayland support for most Chrome and Electron apps.
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  imports = [
    ./firefox.nix
    ./hyprland.nix
    ./mako.nix
  ];
}
