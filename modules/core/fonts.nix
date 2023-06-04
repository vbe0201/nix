{ pkgs, ... }: {
  fonts = {
    fontDir.enable = true;
    enableDefaultFonts = true;

    fontconfig.defaultFonts = {
      serif = ["NotoSerif Nerd Font" "Noto Serif"];
      sansSerif = ["Hack Nerd Font" "NotoSans Nerd Font" "Noto Sans"];
      monospace = ["FiraCode Nerd Font" "Fira Code"];
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
