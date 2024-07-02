{
  lib,
  pkgs,
  isWSL,
  ...
}: {
  # rustup and cargo install binaries to this path.
  home.sessionPath = ["$HOME/.cargo/bin"];

  home.sessionVariables = {
    RUSTC_WRAPPER = "sccache";
  };

  home.packages = with pkgs;
    [
      gcc
      gdb
      rustup
      sccache
    ]
    ++ lib.optionals (!isWSL) [
      python311
      unstable.jetbrains.clion
      unstable.jetbrains.rider
      unstable.zed-editor
    ];
}
