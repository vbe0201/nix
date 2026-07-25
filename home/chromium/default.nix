{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.mine.chromium = {
    enable = mkEnableOption "Chromium browser";

    defaultBrowser = mkOption {
      description = "Whether Chromium should be the default browser";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.mine.chromium.enable {
    home.sessionVariables =
      {
        CHROME_EXECUTABLE = lib.getExe config.programs.chromium.package;
      }
      // optionalAttrs config.mine.chromium.defaultBrowser {
        BROWSER = lib.getExe config.programs.chromium.package;
      };

    programs.chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium.override {enableWideVine = true;};
      extensions = [
        {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # uBlock Origin
        {id = "iplffkdpngmdjhlpjmppncnlhomiipha";} # Unpaywall
        {id = "ldpochfccmkkmhdbclfhpagapcfdljkj";} # Decentraleyes
        {id = "pkehgijcmpdhfbdbbnkijodmdjhbjlgp";} # Privacy Badger
        {id = "ghmbeldphafepmbegfdlkpapadhbakde";} # Proton Pass
        {id = "jplgfhpmjnbigmhklmmbgecoobifkmpa";} # Proton VPN
      ];
    };
  };
}
