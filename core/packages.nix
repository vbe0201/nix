{ pkgs, ... }: {
  ## List of globally installed packages.
  ##
  ## Software that does not require additional configuration
  ## usually goes here.
  environment.systemPackages = with pkgs; [
    discord
    gcc
  ];
}
