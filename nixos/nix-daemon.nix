## Configures nix-daemon and the general operating environment.
## The options here try to be machine-agnostic for my needs.
{ ... }: {
  system.stateVersion = "22.11";

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    settings = {
      allowed-users = ["@wheel"];
      trusted-users = ["root" "@wheel"];
      auto-optimise-store = true;
    };

    optimise = {
      automatic = true;
      dates = ["20:00"];
    };

    # Run garbage collector every Sunday at 9pm.
    gc = {
      automatic = true;
      dates = "Sun 21:00";
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs.config.allowUnfree = true;
}
