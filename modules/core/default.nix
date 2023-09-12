{ lib, isWSL, ... }: {
  imports = [
    ./fonts.nix
    ./locale.nix
    ./nix-daemon.nix
    ./users.nix
    ./zsh.nix
  ] ++ lib.optionals(!isWSL) [
    ./networking.nix
  ];
}
