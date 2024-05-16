{pkgs, ...}: {
  home.packages = with pkgs; [
    unstable.xournalpp
  ];
}
