{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.mine.apps.utils = {
    enable = mkEnableOption "general utilities";
  };

  config = mkIf config.mine.apps.utils.enable {
    programs = {
      # Modern replacement for cat(1).
      bat.enable = true;

      # Tool for navigating directories.
      broot = {
        enable = true;
        settings.verbs = [
          {
            name = "view";
            invocation = "view";
            key = "enter";
            execution = "bat {file}";
            leave_broot = false;
            apply_to = "file";
          }
        ];
      };

      # A smarter cd command.
      zoxide.enable = true;
    };

    home.packages = with pkgs; [
      tokei
      ripgrep
      xan
      bottom
      du-dust
      procs
      pciutils
      p7zip
      atool
      wget
      dtrx
      iputils
      file
      asciinema
      fastfetch
      ffmpeg
    ];
  };
}
