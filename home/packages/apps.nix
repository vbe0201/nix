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
    thunderbird
    unstable.proton-pass
    unstable.protonmail-bridge-gui
    unstable.protonvpn-gui
    v4l-utils
    wireshark
    zoom-us
  ];
}
