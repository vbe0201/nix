{ inputs, lib, pkgs, isWSL, ... }:
  let
    inherit (inputs) devenv;

  in {
    home.sessionVariables = {
      RUSTC_WRAPPER = "sccache";
    } // lib.optionalAttrs (!isWSL) {
      GHIDRA_INSTALL_DIR = "${pkgs.ghidra-bin}/lib/ghidra";
    };

    # rustup and cargo install binaries to this path.
    home.sessionPath = ["$HOME/.cargo/bin"];

    home.packages = with pkgs; [
      # Development
      devenv.packages."${system}".devenv
      rustup
      sccache

      # System utilities
      ouch
      bat
      exa
      fd
      ripgrep
      tokei
      wget
    ] ++ lib.optionals (!isWSL) [
      # Applications
      flameshot
      ghidra-bin
      gimp
      keepassxc
      obs-studio
      wireshark

      # Communication
      discord

      # Development
      python311
      gdb
      gnumake
      unstable.jetbrains.clion
      unstable.jetbrains.rider
      llvmPackages_latest.clang
      llvmPackages_latest.lldb
      llvmPackages_latest.stdenv
      valgrind
      vscode

      # Archives
      ark
      unrar
      unzip
      atool
      zip
      p7zip

      # System utilities
      ffmpeg
      nix-prefetch-docker
      ntfs3g
      pciutils
    ];
  }
