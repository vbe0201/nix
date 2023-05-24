{ pkgs, ... }: {
  # Environment variables for improved UX in Firefox.
  home.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
  };

  home.packages = with pkgs; [firefox];
}
