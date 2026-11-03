{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.mine.lutris = {
    enable = mkEnableOption "lutris config";
  };

  config = mkIf config.mine.lutris.enable {
    programs.lutris = {
      enable = true;

      protonPackages = with pkgs; [
        proton-ge-bin
      ];

      extraPackages = with pkgs; [
        umu-launcher
      ];
    };
  };
}
