{pkgs, ...}: {
  home.packages = with pkgs; [nil alejandra black unstable.ruff];

  programs.vscode = {
    enable = true;

    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;

    userSettings = {
      "editor.fontSize" = 15;
      "editor.fontFamily" = "'Fira Code Nerd Font', 'Droid Sans Mono', 'monospace'";
      "editor.fontLigatures" = true;
      "editor.selectionClipboard" = false;
      "files.autoSave" = "afterDelay";
      # NOTE: Depends on the `enkia.tokyo-night` extension.
      "workbench.colorTheme" = "Tokyo Night";
      "workbench.startupEditor" = "none";

      "rust-analyzer.rustfmt.rangeFormatting.enable" = true;
      "rust-analyzer.check.command" = "clippy";
      "rust-analyzer.inlayHints.lifetimeElisionHints.enable" = "skip_trivial";

      "[python]" = {
        "editor.formatOnSave" = true;
        "editor.codeActionsOnSave" = {
          "source.fixAll" = true;
          "source.organizeImports" = true;
        };
      };
      # NOTE: Depends on the `black` package.
      "python.formatting.provider" = "black";
      "python.analysis.inlayHints.functionReturnTypes" = true;
      "python.analysis.inlayHints.variableTypes" = true;
      "python.analysis.typeCheckingMode" = "basic";
      "python.testing.pytestEnabled" = true;
      "python.terminal.activateEnvironment" = false;
      # NOTE: Depends on the `ruff` package.
      "ruff.path" = ["ruff"];

      "nix.enableLanguageServer" = true;
      # NOTE: Depends on the `nil` package.
      "nix.serverPath" = "nil";
      "[nix]" = {
        # NOTE: Depends on the `alejandra` package.
        "editor.defaultFormatter" = "kamadorueda.alejandra";
        "editor.formatOnSave" = true;
      };

      "editor.quickSuggestions" = {
        "other" = "inline";
      };
    };

    extensions = with pkgs.unstable.vscode-extensions; [
      enkia.tokyo-night
      editorconfig.editorconfig
      jnoortheen.nix-ide
      kamadorueda.alejandra
      mkhl.direnv
      tamasfe.even-better-toml
      matklad.rust-analyzer
      ms-python.python
      charliermarsh.ruff
    ];
  };
}
