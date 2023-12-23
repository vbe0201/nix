{pkgs, ...}: {
  home.packages = with pkgs; [alejandra];

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
      "editor.formatOnSave" = true;
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
      "python.analysis.inlayHints.functionReturnTypes" = true;
      "python.analysis.inlayHints.variableTypes" = true;
      "python.analysis.typeCheckingMode" = "basic";
      "python.testing.pytestEnabled" = true;
      "python.terminal.activateEnvironment" = false;
      "ruff.path" = ["${pkgs.unstable.ruff}/bin/ruff"];

      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "${pkgs.nil}/bin/nil";
      "[nix]" = {
        # NOTE: Depends on the `alejandra` package.
        "editor.defaultFormatter" = "kamadorueda.alejandra";
        "editor.formatOnSave" = true;
      };

      "zig.path" = "";
      "zig.zls.path" = "${pkgs.unstable.zls}/bin/zls";
      "zig.initialSetupDone" = true;
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
      ziglang.vscode-zig
    ];
  };
}
