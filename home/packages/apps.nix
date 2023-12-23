{pkgs, ...}: {
  home.sessionVariables = {
    GHIDRA_INSTALL_DIR = "${pkgs.ghidra-bin}/lib/ghidra";
  };

  home.packages = with pkgs; [
    discord
    flameshot
    ghidra-bin
    gimp
    keepassxc
    obs-studio
    wireshark
    zoom-us
  ];
}
