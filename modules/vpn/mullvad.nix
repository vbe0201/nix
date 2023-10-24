{pkgs, ...}: {
  # Run the mullvad daemon with the GUI app.
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };
}
