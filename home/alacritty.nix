{
  config,
  pkgs,
  ...
}: let
  bindKey = key: mods: action: mode: {
    inherit key mods action mode;
  };

  bindKeyNoMode = key: mods: action: {
    inherit key mods action;
  };

  bindKeyNoModsOrModes = key: action: {
    inherit key action;
  };
in {
  home.sessionVariables = {
    TERMINAL = "${config.programs.alacritty.package}/bin/alacritty";
  };

  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;

    settings = {
      env.term = "xterm-256color";

      window = {
        dimensions = {
          columns = 0;
          lines = 0;
        };

        padding = {
          x = 1;
          y = 1;
        };

        dynamic_title = true;
        dynamic_padding = false;

        decorations = "full";

        opacity = 1.0;
      };

      scrolling = {
        history = 100000;
        multiplier = 1;
      };

      font = {
        normal = {
          family = "Hack";
          style = "Regular";
        };

        bold = {
          family = "Hack";
          style = "Bold";
        };

        italic = {
          family = "Hack";
          style = "Italic";
        };

        size = 12;

        offset = {
          x = 0;
          y = 0;
        };

        glyph_offset = {
          x = 0;
          y = 0;
        };
      };

      debug = {
        persistent_logging = false;
      };

      # Tokyo Night color scheme (Night).
      colors = {
        primary = {
          background = "#1a1b26";
          foreground = "#c0caf5";
        };

        normal = {
          black = "#414868";
          red = "#f7768e";
          green = "#9ece6a";
          yellow = "#e0af68";
          blue = "#7aa2f7";
          magenta = "#bb9af7";
          cyan = "#7dcfff";
          white = "#a9b1d6";
        };

        bright = {
          black = "#414868";
          red = "#f7768e";
          green = "#9ece6a";
          yellow = "#e0af68";
          blue = "#7aa2f7";
          magenta = "#bb9af7";
          cyan = "#7dcfff";
          white = "#c0caf5";
        };

        indexed_colors = [
          {
            index = 16;
            color = "0xff9e64";
          }
          {
            index = 17;
            color = "0xdb4b4b";
          }
        ];

        draw_bold_text_with_bright_colors = true;
      };

      bell = {
        animation = "EaseOutExpo";
        duration = 0;
      };

      selection = {
        semantic_escape_chars = ",│`|:\"' ()[]{}<>";
        save_to_clipboard = true;
      };

      mouse.bindings = [
        {
          mouse = "Middle";
          action = "PasteSelection";
        }
      ];

      cursor = {
        style = {
          shape = "Block";
          blinking = "On";
        };
        unfocused_hollow = true;
      };

      live_config_reload = true;

      keyboard.bindings = [
        (bindKey "PageUp" "Shift" "ScrollPageUp" "~Alt")
        (bindKey "PageDown" "Shift" "ScrollPageDown" "~Alt")
        (bindKey "Home" "Shift" "ScrollToTop" "~Alt")
        (bindKey "End" "Shift" "ScrollToBottom" "~Alt")
        (bindKeyNoModsOrModes "Copy" "Copy")
        (bindKeyNoModsOrModes "Paste" "Paste")
        (bindKeyNoMode "Equals" "Control" "IncreaseFontSize")
        (bindKeyNoMode "Minus" "Control" "DecreaseFontSize")
        (bindKeyNoMode "Key0" "Control" "ResetFontSize")
      ];
    };
  };
}
