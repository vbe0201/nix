{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.mine.tmux = {
    enable = mkEnableOption "tmux config";
  };

  config = mkIf config.mine.tmux.enable {
    programs.tmux = {
      enable = true;
      shortcut = "a";
      baseIndex = 1;
      tmuxp.enable = true;
      newSession = true;
      mouse = true;
      clock24 = true;
      historyLimit = 50000;

      escapeTime = 0;

      plugins = with pkgs; [
        tmuxPlugins.better-mouse-mode
      ];

      extraConfig = ''
        set -g default-terminal "xterm-256color"
        set -ga terminal-overrides ",*256col*:Tc"
        set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
        set-environment -g COLORTERM "truecolor"

        bind | split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"
        bind c new-window -c "#{pane_current_path}"

        unbind '"'
        unbind %

        # Switch panes using Alt + hjkl.
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R

        # Session shortcuts.
        bind S command-prompt -p "New Session:" "new-session -A -s '%%'"
        bind K confirm kill-session
      '';
    };

    programs.tmate.enable = true;
  };
}
