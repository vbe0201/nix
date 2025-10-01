{
  config,
  lib,
  ...
}:
with lib; {
  imports = [
    ./avahi.nix
  ];

  options.mine.networking = {
    enable = mkEnableOption "network configuration";
  };

  config = mkIf config.mine.networking.enable {
    networking = {
      networkmanager = {
        enable = true;
        connectionConfig = {
          "connection.mdns" = 2;
        };
      };

      # https://one.one.one.one/dns/
      nameservers = [
        "1.1.1.1"
        "1.0.0.1"
        "2606:4700:4700::1111"
        "2606:4700:4700::1001"
      ];

      # No need for wpa_supplicant as NetworkManager is used.
      wireless.enable = false;

      # Conflicts with NetworkManager's dhclient as both programs
      # try to bind to the same address. So we disable it here.
      dhcpcd.enable = false;
    };

    services = {
      openssh = {
        enable = true;
        settings = {
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
          PermitRootLogin = "no";
          X11Forwarding = false;
        };
        extraConfig = ''
          AllowAgentForwarding yes
          AllowStreamLocalForwarding no
          AuthenticationMethods publickey
        '';
      };

      resolved.enable = true;
    };

    users.users.vale.extraGroups = ["networkmanager"];
  };
}
