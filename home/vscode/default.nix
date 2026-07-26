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
      code = lib.getExe config.programs.vscodium.package;
    };

    programs.vscodium = {
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
          "terminal.integrated.initialHint" = false;

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

          "C_Cpp.intelliSenseEngine" = "disabled";
          "C_Cpp.clang_format_fallbackStyle" = "none";

          "nix.enableLanguageServer" = true;
          "nix.serverPath" = lib.getExe pkgs.nil;
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
