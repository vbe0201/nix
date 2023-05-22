{ pkgs, ... }: {
  programs.gpg.enable = true;

  home.packages = with pkgs; [pinentry-qt];
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "qt";
  };
}
