{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  inherit (builtins) readFile;

  gitIdentity = pkgs.writeShellScriptBin "git-identity" (readFile ./git-identity);
in {
  options.mine.git = {
    enable = mkEnableOption "git";
  };

  config = mkIf config.mine.git.enable {
    home.packages = [gitIdentity];

    programs = {
      fzf.enable = true;
      gh.enable = true;
    };

    programs.git = {
      enable = true;
      package = pkgs.gitFull;

      signing = {
        key = mkDefault "AB0A082D7A817911";
        signByDefault = true;
      };

      settings = {
        pull.rebase = true;
        init.defaultBranch = "main";
        push.autoSetupRemote = true;

        user = {
          name = mkDefault "Valentin B.";
          email = mkDefault "valentin.be@protonmail.com";

          useConfigOnly = true;

          personal = {
            name = "Valentin B.";
            email = "valentin.be@protonmail.com";
            signingKey = "AB0A082D7A817911";
          };
        };

        alias = {
          # This seems redundant as `git identity` will already call
          # the `git-identity` script, but this gives autocomplete.
          identity = "! git-identity";

          id = "! git-identity";
          st = "status";
          co = "checkout";
          lp = "log -p";
          p = "push";
          c = "commit";
          a = "add";
        };
      };

      lfs.enable = true;
    };
  };
}
