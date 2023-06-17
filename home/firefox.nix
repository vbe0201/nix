{ config, osConfig, lib, pkgs, ... }:
  let
    isX11 = osConfig.services.xserver.enable;

  in {
    home.sessionVariables = {
      MOZ_USE_XINPUT2 = "1";
    } // lib.optionalAttrs (!isX11) {
      MOZ_ENABLE_WAYLAND = "1";
    };

    programs.firefox = {
      enable = true;
      package = if isX11 then pkgs.unstable.firefox-bin else pkgs.firefox-wayland;
      profiles = {
        ${config.home.username} = {
          search = {
            default = "Google";
            force = true;
          };
          settings = {
            "browser.toolbars.bookmarks.visibility" = "newtab";
          };
        };
      };
    };
  }
