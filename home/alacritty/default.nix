{
  config,
  lib,
  ...
}:
with lib; let
  bindKey = key: mods: action: mode: {
    inherit key mods action mode;
  };

  bindKeyNoMode = key: mods: action: {
    inherit key mods action;
  };

  bindKeyNoModsOrMode = key: action: {
    inherit key action;
  };
in {
  options.mine.alacritty = {
    enable = mkEnableOption "Alacritty as the terminal emulator";
  };

  config = mkIf config.mine.alacritty.enable {
    home.sessionVariables = {
      TERMINAL = "${config.programs.alacritty.package}/bin/alacritty";
    };

    programs.alacritty = {
      enable = true;

      settings = {
        env.term = "xterm-256color";

        window.opacity = 1;

        scrolling = {
          history = 100000;
          multiplier = 1;
        };

        font = {
          size = 12;
          normal.family = "monospace";

          bold = {
            family = "monospace";
            style = "Bold";
          };

          italic = {
            family = "monospace";
            style = "Italic";
          };
        };

        debug.persistent_logging = false;

        cursor.style.blinking = "On";

        general.live_config_reload = true;

        keyboard.bindings = [
          (bindKey "PageUp" "Shift" "ScrollPageUp" "~Alt")
          (bindKey "PageDown" "Shift" "ScrollPageDown" "~Alt")
          (bindKey "Home" "Shift" "ScrollToTop" "~Alt")
          (bindKey "End" "Shift" "ScrollToBottom" "~Alt")
          (bindKeyNoModsOrMode "Copy" "Copy")
          (bindKeyNoModsOrMode "Paste" "Paste")
          (bindKeyNoMode "Equals" "Control" "IncreaseFontSize")
          (bindKeyNoMode "Minus" "Control" "DecreaseFontSize")
          (bindKeyNoMode "Key0" "Control" "ResetFontSize")
        ];
      };
    };
  };
}
