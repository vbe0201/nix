{...}: {
  programs.zed-editor = {
    enable = true;

    userSettings = {
      assistant.enabled = false;

      hour_format = "hour24";
      auto_update = false;
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
        env = {
          TERM = "alacritty";
        };
        font_family = "FiraCode Nerd Font";
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
        clangd = {
          binary = {
            path_lookup = true;
            arguments = [
              "--clang-tidy"
              "--background-index"
              "--header-insertion=iwyu"
              "--completion-style=detailed"
              "--enable-config"
            ];
          };
        };

        rust-analyzer = {
          initialization_options = {
            cargo = {
              allFeatures = true;
              buildScripts.rebuildOnSave = true;
            };
          };
          procMacro.enable = true;
          checkOnSave.command = "clippy";
          hover.references.enabled = true;
          imports = {
            prefix = "crate";
            preferPrelude = true;
            granularity.enforce = true;
          };
          inlayHints = {
            lifetimeElisionHints = {
              useParameterNames = true;
              enable = "skip_trivial";
            };
          };
          binary.path_lookup = true;
        };

        nix = {
          binary.path_lookup = true;
        };
      };

      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      load_direnv = "shell_hook";
      base_keymap = "VSCode";
      theme = {
        mode = "system";
        light = "One Light";
        dark = "One Dark";
      };
      show_whitespaces = "boundary";
      ui_font_size = 15;
      buffer_font_size = 15;
    };
  };
}
