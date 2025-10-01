{
  config,
  lib,
  ...
}:
with lib; {
  options.mine.zed = {
    enable = mkEnableOption "Zed editor";
  };

  config = mkIf config.mine.zed.enable {
    # The Nix package calls the binary zeditor, which is annoying.
    home.shellAliases = {
      zed = "${config.programs.zed-editor.package}/bin/zeditor";
    };

    programs.zed-editor = {
      enable = true;

      userSettings = {
        assistant.disabled = false;
        disable_ai = true;
        auto_update = false;
        hour_format = "hour24";

        terminal = {
          alternate_scroll = "off";
          blinking = "off";
          copy_on_select = false;
          dock = "bottom";

          detect_venv = {
            on = {
              directories = [".env" "env" ".venv" "venv"];
              activate_script = "default";
            };
          };

          font_family = "FiraCode Nerd Font Mono";
          font_features = null;
          font_size = null;
          line_height = "comfortable";

          option_as_meta = false;
          button = false;
          shell = "system";
          toolbar.title = true;
          working_directory = "current_project_directory";
        };

        lsp = {
          clangd.binary = {
            path_lookup = true;
            arguments = [
              "--clang-tidy"
              "--background-index"
              "--header-insertion=iwyu"
              "--completion-style=detailed"
              "--enable-config"
            ];
          };

          rust-analyzer = {
            initialization_options.cargo = {
              allFeatures = true;
              buildScripts.rebuildOnSave = true;
            };
            procMacro.enable = true;
            checkOnSave.command = "clippy";
            hover.references.enabled = true;
            imports = {
              prefix = "crate";
              preferPrelude = true;
              granularity.enforce = true;
            };
            inlayHints.lifetimeElisionHints = {
              useParameterNames = true;
              enable = "skip_trivial";
            };
            binary.path_lookup = true;
          };

          nix.binary.path_lookup = true;
        };

        telemetry = {
          diagnostics = false;
          metrics = false;
        };

        load_direnv = "shell_hook";
        base_keymap = "VSCode";

        ui_font_size = 15;
        buffer_font_size = 15;
      };
    };
  };
}
