{ lib, isWSL, ... }: {
  imports = [
    ./locale.nix
    ./nix-daemon.nix
    ./users.nix
    ./zsh.nix
  ] ++ lib.optionals(!isWSL) [
    ./fonts.nix
    ./networking.nix
  ];
}
