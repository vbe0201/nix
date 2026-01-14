{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  mkZshPlugin = src: rec {
    inherit src;
    name = src.pname;
    file = "share/${name}/${name}.zsh";
  };
in {
  options.mine.zsh = {
    enable = mkEnableOption "Z Shell";
  };

  config = mkIf config.mine.zsh.enable {
    programs.bat.enable = true;
    programs.eza.enable = true;

    programs.delta = {
      enable = true;
      enableGitIntegration = true;
    };

    programs.zsh = {
      enable = true;

      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      autocd = true;
      dotDir = "${config.home.homeDirectory}/.config/zsh";

      shellAliases = {
        ls = "eza";
        cat = "bat";
        diff = "delta --diff-so-fancy --side-by-side";

        rebuild = "sudo nixos-rebuild switch";
      };

      history = {
        path = "${config.xdg.dataHome}/zsh/zshHistory";
        extended = true;
      };

      oh-my-zsh.enable = true;

      plugins = with pkgs; [
        (mkZshPlugin zsh-history-substring-search)
      ];

      envExtra = ''
        export GPG_TTY="$(tty)"
      '';
    };

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    programs.nix-index = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.nix-index-database.comma.enable = true;

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.starship = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        add_newline = true;

        username.show_always = true;
        nix_shell.heuristic = true;

        character = {
          success_symbol = "[λ ›](bold green)";
          error_symbol = "[λ ›](bold red)";
          vicmd_symbol = "[λ ·](bold green)";
        };

        cmd_duration = {
          show_notifications = false;
          min_time = 10000;
          min_time_to_notify = 60000;
        };

        command_timeout = 1000;
      };
    };
  };
}
