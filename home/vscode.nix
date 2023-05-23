{ pkgs, ... }: {
  # NOTE: Needed for Wayland compatibility.
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      # TODO: Extensions.
    ];
  };
}
