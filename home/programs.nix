{ inputs, pkgs, ... }:
  let
    inherit (inputs) devenv;

  in {
    home.packages = with pkgs; [
      # Applications
      ghidra-bin
      gimp
      obs-studio

      # Communication
      discord

      # Development
      python3
      cmake
      devenv.packages."${system}".devenv
      gdb
      gnumake
      gradle
      llvmPackages_latest.clang
      llvmPackages_latest.lldb
      llvmPackages_latest.stdenv
      ninja
      unstable.openjdk19
      rustup
      sccache
      valgrind

      # Archives
      ark
      unrar
      unzip
      atool
      zip
      p7zip

      # System utilities
      bat
      direnv
      exa
      fd
      ffmpeg
      ntfs3g
      pciutils
      ripgrep
      tokei
      vim
      wget
    ];
  }
