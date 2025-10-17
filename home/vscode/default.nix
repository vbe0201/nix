{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.mine.vscode = {
    enable = mkEnableOption "Visual Studio Code editor";
  };

  config = mkIf config.mine.vscode.enable {
    programs.vscode = {
      enable = true;

      profiles.default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;

        userSettings = {
          "editor.fontSize" = 15;
          "editor.fontFamily" = "'JuliaMono', 'Droid Sans Mono', 'monospace'";
          "editor.fontLigatures" = true;
          "editor.selectionClipboard" = false;
          "files.autoSave" = "afterDelay";
          "editor.formatOnSave" = true;

          "workbench.editor.empty.hint" = "hidden";
          "workbench.startupEditor" = "none";

          "extensions.ignoreRecommendations" = true;

          "chat.agent.enabled" = false;
          "chat.disableAIFeatures" = true;
          "chat.commandCenter.enabled" = false;

          "github.copilot.enable" = false;

          "rust-analyzer.check.command" = "clippy";
          "rust-analyzer.inlayHints.lifetimeElisionHints.enable" = "skip_trivial";

          "[python]" = {
            "editor.formatOnSave" = true;
            "editor.codeActionsOnSave" = {
              "source.fixAll" = "explicit";
              "source.organizeImports" = "explicit";
            };
          };
          "python.testing.pytestEnabled" = true;
          "python.terminal.activateEnvironment" = false;
          "ruff.path" = ["${pkgs.unstable.ruff}/bin/ruff"];

          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "${pkgs.nil}/bin/nil";
          "[nix]" = {
            "editor.defaultFormatter" = "kamadorueda.alejandra";
            "editor.formatOnSave" = true;
          };
        };

        extensions = with pkgs.unstable.vscode-extensions; [
          editorconfig.editorconfig
          jnoortheen.nix-ide
          kamadorueda.alejandra
          mkhl.direnv
          tamasfe.even-better-toml
          rust-lang.rust-analyzer
          ms-python.python
          ms-vscode-remote.remote-ssh
          ms-vscode-remote.remote-ssh-edit
          charliermarsh.ruff
        ];
      };
    };
  };
}
