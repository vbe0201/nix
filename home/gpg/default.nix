{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.mine.gpg = {
    enable = mkEnableOption "GPG agent";
  };

  config = mkIf config.mine.gpg.enable {
    programs.gpg = {
      enable = true;

      settings = {
        default-key = mkDefault "0xB5875C2FA3770584";
        trusted-key = mkDefault "0xB5875C2FA3770584";

        no-greeting = true;
        throw-keyids = true;
      };

      scdaemonSettings = {
        disable-ccid = true;
        reader-port = "Yubico Yubi";
      };

      publicKeys = [
        {
          source = ./yubikey.asc;
          trust = 5;
        }
      ];
    };

    home.packages = with pkgs; [
      paperkey
      pgpdump
      cryptsetup
    ];

    services.gpg-agent = {
      enable = true;

      enableSshSupport = true;
      enableZshIntegration = true;
      pinentry.package = pkgs.pinentry-qt;
    };
  };
}
