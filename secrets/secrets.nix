let
  yubikey = "age1yubikey1qvm8ruv0vy6e8893q3vx9730yz95uqyxdyaucennynjq0rx44rmhkrexvne";

in {
  # OpenVPN network configurations.
  "sext.ovpn.age".publicKeys = [yubikey];

  # User account passwords.
  "vale-password.age".publicKeys = [yubikey];
}
