{
  inputs,
  lib,
  ...
}:
with lib; {
  imports = with inputs; [
    ./alacritty
    ./applications
    ./chromium
    ./firefox
    ./fonts
    ./git
    ./gpg
    ./tmux
    ./vscode
    ./xdg
    ./zed
    ./zsh

    catppuccin.homeModules.catppuccin
    nix-index-database.homeModules.nix-index
  ];

  # Enable global theme for supported applications.
  catppuccin = {
    enable = true;
    accent = mkDefault "red";
    flavor = mkDefault "mocha";
  };

  programs.home-manager.enable = true;

  # Leave this value untouched at all times.
  home.stateVersion = "22.11";
}
