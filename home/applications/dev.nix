{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  jb-wayland = pkg: (pkg.override {
    forceWayland = true;
  });
in {
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

      (jb-wayland unstable.jetbrains.clion)
      (jb-wayland unstable.jetbrains.idea)
      (jb-wayland unstable.jetbrains.rider)

      (unstable.ghidra.withExtensions (p:
        with p; [
          findcrypt
          ghidra-delinker-extension
          machinelearning
          ret-sync
          sleighdevtools
        ]))
      wireshark
      unstable.imhex
    ];
  };
}
