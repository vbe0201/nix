{inputs, ...}: {
  ## An overlay which enables accessing unstable nixpkgs
  ## through `pkgs.unstable`, when applied.
  ##
  ## Also enables access to unfree packages by default.
  unstable-unfree-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };
  };
}
