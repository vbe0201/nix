{pkgs, ...}: {
  home.packages = with pkgs; [
    ark
    atool
    bat
    eza
    fd
    nix-prefetch-docker
    ouch
    p7zip
    pciutils
    ripgrep
    tokei
    unrar
    unzip
    wget
    zip
  ];
}
