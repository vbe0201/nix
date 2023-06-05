{ pkgs, stdenv }:
  let
    devkitArmImage = pkgs.dockerTools.pullImage {
      imageName = "devkitpro/devkitarm";
      imageDigest = "sha256:ebc5669e4cef225fc016564bd489d016b949e39699367233230d0b32f0356a8b";
      sha256 = "19vg0mx4ymlm5frm5wa59lvlaa5qv87xvii6i3vd1c9v5w4l1wjb";
      finalImageTag = "20230526";
    };

    devkitA64Image = pkgs.dockerTools.pullImage {
      imageName = "devkitpro/devkita64";
      imageDigest = "sha256:1c615b2b643d65c6e0a6b0de91da76f47cbc9978bf0423e37bec98aec0685763";
      sha256 = "093hhqav06pfaqpbynfplsq1x2a57jk9r0q4scgkc1g9s27xbgbr";
      finalImageTag = "20230527";
    };

    devkitPpcImage = pkgs.dockerTools.pullImage {
      imageName = "devkitpro/devkitppc";
      imageDigest = "sha256:0244891023f91c2c3eb249fc7295a94c389c523cdc2495a2acf309782b078112";
      sha256 = "0nrbx8kf5z3z0qjf5dzgjcvf1zfafj50hb15d8vzqaf07rizlrjs";
      finalImageTag = "20230526";
    };

    makeDevKit = name: image: stdenv.mkDerivation {
      name = name;
      src = image;

      nativeBuildInputs = with pkgs; [autoPatchelfHook];
      buildInputs = with pkgs; [
        stdenv.cc.cc
        ncurses6
      ];

      buildPhase = "true";
      installPhase = ''
        mkdir -p $out
        cp -r $src/* $out
        rm -rf $out/pacman
      '';
    };

  in {
    devkitArm = makeDevKit "devkitARM" devkitArmImage;
    devkitA64 = makeDevKit "devkitA64" devkitA64Image;
    devkitPpc = makeDevKit "devkitPPC" devkitPpcImage;
  }
