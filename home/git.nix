{ pkgs, ... }: {
  programs.git = {
    enable = true;
    package = pkgs.unstable.gitAndTools.gitFull;

    userName = "Valentin B.";
    userEmail = "valentin.be@protonmail.com";

    signing = {
      key = "BC73773F6D8139A0";
      signByDefault = true;
    };

    extraConfig = {
      pull.rebase = true;
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };

    lfs.enable = true;

    aliases = {
      st = "status";
      co = "checkout";
      lp = "log -p";
      p = "push";
      c = "commit";
      a = "add";
    };
  };
}
