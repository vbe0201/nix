{pkgs, ...}: {
  programs.gpg = {
    enable = true;

    settings = {
      default-key = "0xB5875C2FA3770584";
      trusted-key = "0xB5875C2FA3770584";

      no-greeting = true;
      throw-keyids = true;
    };

    scdaemonSettings = {
      disable-ccid = true;
      reader-port = "Yubico Yubi";
    };

    publicKeys = [
      {
        source = ./keys/yubikey.asc;
        trust = 5;
      }
    ];
  };

  home.packages = with pkgs; [
    # Tools for backing up keys.
    paperkey
    pgpdump
    cryptsetup

    # Securely accept passphrases.
    pinentry-qt
  ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
    pinentryFlavor = "qt";
  };
}
