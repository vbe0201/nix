{
  config,
  lib,
  ...
}:
with lib; {
  options.mine.firefox = {
    enable = mkEnableOption "Firefox browser";

    defaultBrowser = mkOption {
      description = "Whether Firefox should be the default browser";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.mine.firefox.enable {
    home.sessionVariables =
      {
        MOZ_USE_XINPUT2 = "1";
      }
      // optionalAttrs config.mine.firefox.defaultBrowser {
        BROWSER = "${config.programs.firefox.package}/bin/firefox";
      };

    programs.firefox = {
      enable = true;
      profiles."${config.home.username}" = {
        search = {
          default = "google";
          force = true;
        };

        settings = {
          "browser.toolbars.bookmarks.visibility" = "newtab";

          "general.autoScroll" = true;

          "security.webauth.u2f" = true;
          "security.webauth.webauthn" = true;
          "security.webauth.webauthn_enable_softtoken" = true;
          "security.webauth.webauthn_enable_usbtoken" = true;
        };
      };
    };

    catppuccin.firefox.profiles.default.enable = false;
  };
}
