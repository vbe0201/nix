## Installs universally useful fonts on the system.
{ pkgs, ... }: {
  fonts = {
    fontDir.enable = true;
    enableDefaultFonts = true;

    fontconfig.defaultFonts = {
      serif = ["Noto Serif Nerd Font" "Noto Serif"];
      sansSerif = ["Hack Nerd Font" "NotoSans Nerd Font" "Noto Sans"];
      monospace = ["Fira Code Nerd Font" "Fira Code Font"];
      emoji = ["Noto Color Emoji"];
    };

    fonts = with pkgs; [
      (nerdfonts.override { fonts = ["FiraCode" "Hack" "Noto"]; })
      fira-code
      fira-code-symbols
      inconsolata
      jetbrains-mono
      julia-mono
      material-icons
      material-design-icons
      noto-fonts
      noto-fonts-emoji
      ubuntu_font_family
    ];
  };
}
