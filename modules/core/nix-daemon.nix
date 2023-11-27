{...}: {
  system.stateVersion = "22.11";

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      allowed-users = ["@wheel"];
      trusted-users = ["root" "@wheel"];
      auto-optimise-store = true;
      warn-dirty = false;
    };

    # Optimise the Nix store every day at 8pm.
    optimise = {
      automatic = true;
      dates = ["20:00"];
    };

    # Run garbage collector every Sunday at 9pm.
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
