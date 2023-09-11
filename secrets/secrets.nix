let
  yubikey = "age1yubikey1qvm8ruv0vy6e8893q3vx9730yz95uqyxdyaucennynjq0rx44rmhkrexvne";

  systems = {
    spectre = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN0p+bIcJc2yYukRxv3KCXnlMGsYYnPl2yajBbWgqFVt valentin.be@protonmail.com";
  };

  keysForSystems = sys: bultins.map(s: systems."${s}") sys;

in {
  # System-specific 3DS AES keys.
  "3ds-aes-keys.age".publicKeys = [yubikey];

  # OpenVPN network configurations.
  "sext.ovpn.age".publicKeys = [yubikey];
  "sext-creds.auth.age".publicKeys = [yubikey];

  # User account passwords.
  "vale-password.age".publicKeys = [yubikey] ++ keysForSystems ["spectre"];
}
