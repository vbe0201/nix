{
  inputs,
  lib,
  pkgs,
  system,
  isWSL,
  ...
}: let
  inherit (inputs) devenv;
in {
  # rustup and cargo install binaries to this path.
  home.sessionPath = ["$HOME/.cargo/bin"];

  home.sessionVariables = {
    RUSTC_WRAPPER = "sccache";
  };

  home.packages = with pkgs;
    [
      devenv.packages."${system}".devenv
      rustup
      sccache
    ]
    ++ lib.optionals (!isWSL) [
      python311
      unstable.jetbrains.clion
      unstable.jetbrains.rider
    ];
}
