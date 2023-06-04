{ ... }: {
  imports = [
    ./fonts.nix
    ./locale.nix
    ./networking.nix
    ./nix-daemon.nix
    ./users.nix
    ./zsh.nix
  ];
}
