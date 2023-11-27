{pkgs, ...}: {
  home.packages = with pkgs; [
    citra-nightly
    ryujinx
    dolphin-emu
    melonDS
    duckstation
  ];
}
