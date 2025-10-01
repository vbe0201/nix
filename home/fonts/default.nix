{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  # All the Nerd Fonts.
  nerd-fonts = builtins.filter attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
in {
  options.mine.fonts = {
    enable = mkEnableOption "personal font preferences";
  };

  config = mkIf config.mine.fonts.enable {
    fonts.fontconfig.enable = true;

    home.packages = with pkgs;
      [
        fontconfig

        # Some beautiful UI fonts.
        roboto
        inter
        b612

        # Some nice bitmap and monospace fonts.
        cozette
        tamzen
        departure-mono
        inconsolata
        jetbrains-mono
        julia-mono

        # Noto is also a nice UI font and fixes unicode tofu.
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        noto-fonts-extra
        noto-fonts-monochrome-emoji
      ]
      ++ nerd-fonts;
  };
}
