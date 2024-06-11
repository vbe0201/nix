{
  config,
  pkgs,
  ...
}: {
  home.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
    BROWSER = "firefox";
  };

  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    profiles = {
      ${config.home.username} = {
        search = {
          default = "Google";
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
  };
}
