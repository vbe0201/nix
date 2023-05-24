{ config, pkgs, ... }: {
  # We want to keep the config in sync without making it immutable.
  # TODO: Find a less hacky way to do this.
  xdg.configFile."Code/User/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/config/vscode.json";

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      # TODO: Extensions.
    ];
  };
}
