{pkgs, ...}: {
  home.packages = with pkgs; [
    ryujinx
    dolphin-emu
    melonDS
    duckstation
  ];
}
