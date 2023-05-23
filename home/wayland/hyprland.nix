{ inputs, pkgs, system, ... }:
  let
    inherit (builtins) concatStringsSep genList toString;

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

        general {
          gaps_in = 5
          gaps_out = 20
          border_size = 2

          damage_tracking = full
        }

        decoration {
          rounding = 5
        }

        animations {
          enabled = 1
        }

        # Launch Terminal with SUPER + Enter.
        bind = SUPER,Return,exec,alacritty

        # Change focused window.
        bind = SUPER,h,movefocus,l
        bind = SUPER,j,movefocus,d
        bind = SUPER,k,movefocus,u
        bind = SUPER,l,movefocus,r

        # Alternatively, bind the cursor keys.
        bind = SUPER,Left,movefocus,l
        bind = SUPER,Down,movefocus,d
        bind = SUPER,Up,movefocus,u
        bind = SUPER,Right,movefocus,r

        # Move focused window.
        bind = SUPER_SHIFT,h,movewindow,l
        bind = SUPER_SHIFT,j,movewindow,d
        bind = SUPER_SHIFT,k,movewindow,u
        bind = SUPER_SHIFT,l,movewindow,r

        # Alternatively, bind the cursor keys.
        bind = SUPER_SHIFT,Left,movewindow,l
        bind = SUPER_SHIFT,Down,movewindow,d
        bind = SUPER_SHIFT,Up,movewindow,u
        bind = SUPER_SHIFT,Right,movewindow,r

        # Kill focused window with SUPER + Shift + q.
        bind = SUPER_SHIFT,q,killactive,

        # Toggle fullscreen on selected window with SUPER + f.
        bind = SUPER,f,fullscreen,

        # Toggle tiling/floating.
        bind = SUPER_SHIFT,f,togglefloating,

        # Define workspaces and switching to them.
        ${concatStringsSep "\n" (genList (
          key:
            let
              ws = if key == 0 then 10 else key;
            in ''
              bind = SUPER,${toString key},workspace,${toString ws}
              bind = SUPER_SHIFT,${toString key},movetoworkspacesilent,${toString ws}
            ''
        ) 10)}

        # Resize windows.
        bind = SUPER,r,submap,resize

        submap=resize
        binde=,h,resizeactive,-10 0
        binde=,j,resizeactive,0 10
        binde=,k,resizeactive,0 -10
        binde=,l,resizeactive,10 0
        bind=,escape,submap,reset
        submap=reset

        # Bind screenshot utility.
        bind = ,Print,exec,grimblast --notify copysave area

        # Bind system keys.
        bindl = ,XF86AudioPlay,exec,playerctl play-pause
        bindl = ,XF86AudionPrev,exec,playerctl previous
        bindl = ,XF86AudioNext,exec,playerctl next
        bindle = ,XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
        bindle = ,XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        bindl = ,XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        bindl = ,XF86AudioMicMute,exec,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
      '';
    };
  }
