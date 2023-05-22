## Configures the Graphical User Interface with Hyprland.
{ pkgs, system, hyprland, ... }:
  let
    hyprlandPkg = hyprland.packages."${system}".default.override {
      enableXWayland = true;
      nvidiaPatches = true;
      hidpiXWayland = true;
    };

  in {
    programs.dconf.enable = true;
    programs.hyprland = {
      enable = true;
      package = hyprlandPkg;
    };

    environment.systemPackages = [pkgs.xdg-utils];

    security.polkit.enable = true;

    services.pipewire = {
      enable = true;

      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      pulse.enable = true;
    };

    xdg.portal = {
      enable = true;
      wlr.enable = true;
    };
  }
