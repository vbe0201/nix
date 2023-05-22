{ inputs, pkgs, system, ... }:
  let
    hyprland = inputs.hyprland.packages."${system}".default.override {
      enableXWayland = true;
      nvidiaPatches = true;
      hidpiXWayland = true;
    };

  in {
    home.packages = with pkgs; [
      # Screenshots and screen recording.
      slurp
      grim
      wf-recorder

      # Better Hyprland UX.
      inputs.hyprland-contrib.packages.${system}.grimblast
      inputs.hyprpaper.packages.${system}.default
      wlr-randr
      wl-clipboard

      # Miscellaneous utilities.
      pciutils
      imv
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      package = hyprland;

      systemdIntegration = true;

      recommendedEnvironment = true;

      extraConfig = ''
        # Recommended environment variables for NVIDIA.
        env = LIBVA_DRIVER_NAME,nvidia
        env = XDG_SESSION_TYPE,wayland
        env = GBM_BACKEND,nvidia-drm
        env = __GLX_VENDOR_LIBRARY_NAME,nvidia
        env = WLR_NO_HARDWARE_CURSORS,1

        input {
          kb_layout = us # TODO: Switch to eurkey
          follow_mouse = 1
          sensitivity = 1.0
        }

        # Launch Terminal with SUPER + Enter.
        bind = SUPER,Return,exec,alacritty
      '';
    };
  }
