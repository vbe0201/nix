{ inputs, pkgs, ... }:
  let
    inherit (inputs) devenv;

  in {
    home.sessionVariables = {
      RUSTC_WRAPPER = "sccache";
      GHIDRA_INSTALL_DIR = "${pkgs.ghidra-bin}/lib/ghidra";
    };

    # rustup and cargo install binaries to this path.
    home.sessionPath = ["$HOME/.cargo/bin"];

    home.packages = with pkgs; [
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
      devenv.packages."${system}".devenv
      gdb
      gnumake
      unstable.jetbrains.clion
      unstable.jetbrains.rider
      llvmPackages_latest.clang
      llvmPackages_latest.lldb
      llvmPackages_latest.stdenv
      rustup
      sccache
      valgrind
      vscode

      # Emulation
      citra-nightly
      ryujinx
      dolphin-emu
      melonDS
      duckstation

      # Archives
      ark
      unrar
      unzip
      atool
      zip
      p7zip

      # System utilities
      bat
      exa
      fd
      ffmpeg
      nix-prefetch-docker
      ntfs3g
      pciutils
      ripgrep
      tokei
      wget
    ];
  }
