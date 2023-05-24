{ config, pkgs, ... }:
  let
    inherit (pkgs) fetchFromGitHub;

    zshPlugin = src: rec {
      inherit src;
      name = src.pname;
      file = "share/${name}/${name}.zsh";
    };

    ohMyZsh = fetchFromGitHub {
      owner = "ohmyzsh";
      repo = "ohmyzsh";
      rev = "ec369bb38e873fa2e8954bc45bc192fdb0051313";
      sha256 = "sha256-ZCQZyW+nOD/iYqDA/0L0fSPHbM2VywWWJxBxG2paslY=";
    };

  in {
    home.packages = with pkgs; [comma];

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

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

      plugins = with pkgs; [
        (zshPlugin zsh-syntax-highlighting)
        (zshPlugin zsh-history-substring-search)
      ];

      envExtra = ''
        export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"
        mkdir -p $ZSH_CACHE_DIR/completions

        function load_plugin() {
          source "${ohMyZsh}/plugins/$1/$1.plugin.zsh"
        }
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
