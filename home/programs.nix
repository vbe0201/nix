{ inputs, pkgs, ... }:
  let
    inherit (inputs) devenv;

  in {
    home.sessionVariables = {
      RUSTC_WRAPPER = "sccache";
      GHIDRA_INSTALL_DIR = "${pkgs.ghidra-bin}/lib/ghidra";
    };

    home.sessionPath = ["$HOME/.rustup/bin"];

    home.packages = with pkgs; [
      # Applications
      flameshot
      ghidra-bin
      gimp
      keepassxc
      obs-studio
      wineWowPackages.stable
      winetricks

      # Communication
      discord

      # Development
      python3
      cmake
      devenv.packages."${system}".devenv
      gdb
      gnumake
      gradle
      jetbrains.clion
      jetbrains.idea-ultimate
      kotlin
      llvmPackages_latest.clang
      llvmPackages_latest.lldb
      llvmPackages_latest.stdenv
      ninja
      unstable.openjdk19
      rustup
      sccache
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
      bat
      exa
      fd
      ffmpeg
      nix-prefetch-docker
      ntfs3g
      pciutils
      ripgrep
      tokei
      vim
      wget
    ];
  }
