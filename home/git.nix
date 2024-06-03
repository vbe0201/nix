{
  pkgs,
  isWSL,
  ...
}: {
  programs.git = {
    enable = true;
    package = pkgs.unstable.gitAndTools.gitFull;

    userName = "Valentin B.";
    userEmail = "valentin.be@protonmail.com";

    signing = {
      key =
        if isWSL
        then "7705337EDFD49C2F"
        else "AB0A082D7A817911";
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
