{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Emulation
    citra-nightly
    ryujinx
    dolphin-emu
    melonDS
    duckstation
  ];
}
