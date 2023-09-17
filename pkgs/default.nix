{pkgs}: let
  devkitpro = pkgs.callPackage ./devkitpro {};
in {
  # devkitPro toolchains for homebrew development.
  devkitArm = devkitpro.devkitArm;
  devkitA64 = devkitpro.devkitA64;
  devkitPpc = devkitpro.devkitPpc;
}
