{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.mine.apps.dev = {
    enable = mkEnableOption "software for development";
  };

  config = mkIf config.mine.apps.dev.enable {
    home = {
      sessionVariables = {
        CARGO_TERM_COLOR = "auto";
        RUST_BACKTRACE = "1";
        RUSTC_WRAPPER = "sccache";
        GHIDRA_INSTALL_DIR = "${pkgs.ghidra}/lib/ghidra";
      };

      sessionPath = [
        "$HOME/.cargo/bin"
      ];
    };

    programs.jq.enable = mkDefault true;

    programs.direnv = {
      enable = mkDefault true;
      nix-direnv.enable = mkDefault true;
    };

    home.packages = with pkgs; [
      python314
      rustup
      gcc
      gdb
      lldb
      sccache
      valgrind
      gnumake
      qemu

      unstable.jetbrains.clion
      unstable.jetbrains.idea-ultimate
      unstable.jetbrains.rider
      unstable.jetbrains.pycharm-professional

      (ghidra.withExtensions (p:
        with p; [
          findcrypt
          ghidra-delinker-extension
          machinelearning
          ret-sync
          sleighdevtools
          wasm
        ]))
      wireshark
      unstable.imhex
    ];
  };
}
