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
    home.shellAliases = {
      code = "${config.programs.vscode.package}/bin/codium";
    };

    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;

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

          "rust-analyzer.check.command" = "clippy";
          "rust-analyzer.inlayHints.lifetimeElisionHints.enable" = "skip_trivial";

          "[python]" = {
            "editor.formatOnSave" = true;
            "editor.codeActionsOnSave" = {
              "source.fixAll" = "explicit";
              "source.organizeImports" = "explicit";
            };
          };
          "python.analysis.inlayHints.functionReturnTypes" = true;
          "python.analysis.inlayHints.variableTypes" = true;
          "python.analysis.inlayHints.pytestParameters" = true;
          "python.analysis.typeCheckingMode" = "basic";
          "python.testing.pytestEnabled" = true;
          "python.terminal.activateEnvironment" = false;
          "python.analysis.exclude" = [
            "result"
            ".direnv"
            ".venv"
            "venv"
          ];

          "C_Cpp.intelliSenseEngine" = "disabled";
          "C_Cpp.clang_format_fallbackStyle" = "none";

          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "${pkgs.nil}/bin/nil";
          "[nix]" = {
            "editor.defaultFormatter" = "kamadorueda.alejandra";
            "editor.formatOnSave" = true;
          };

          "direnv.restart.automatic" = true;
        };

        extensions = with pkgs.unstable.vscode-extensions; [
          editorconfig.editorconfig
          jnoortheen.nix-ide
          kamadorueda.alejandra
          mkhl.direnv
          tamasfe.even-better-toml
          rust-lang.rust-analyzer
          ms-python.python
          ms-vscode.cpptools
          llvm-vs-code-extensions.vscode-clangd
          ms-vscode-remote.remote-ssh
          ms-vscode-remote.remote-ssh-edit
          myriad-dreamin.tinymist
        ];
      };
    };
  };
}
