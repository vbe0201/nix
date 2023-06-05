{ config, pkgs, ... }:
  let
    zshPlugin = src: rec {
      inherit src;
      name = src.pname;
      file = "share/${name}/${name}.zsh";
    };

  in {
    programs.zsh = {
      enable = true;

      enableCompletion = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;

      autocd = true;
      dotDir = ".config/zsh";

      shellAliases = {
        ls = "exa";
        cat = "bat";
        diff = "diff --color=auto";
        rg = "ripgrep";

        rebuild = "sudo nixos-rebuild switch";
      };

      history = {
        path = "${config.xdg.dataHome}/zsh/zshHistory";
        extended = true;
      };

      oh-my-zsh = {
        enable = true;
      };

      envExtra = ''
        export GPG_TTY="$(tty)"

        export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"
        mkdir -p $ZSH_CACHE_DIR/completions
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
      };
    };
  }
