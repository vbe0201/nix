let
  keys = import ../ssh-keys.nix;

  hostKeys = [keys.glacier.host keys.spin.host];
  userKeys = [keys.glacier.vale keys.spin.vale];

in {
  # System-specific 3DS AES keys.
  "3ds-aes-keys.age".publicKeys = [keys.glacier.host];

  # OpenVPN network configurations.
  "sext.ovpn.age".publicKeys = userKeys ++ hostKeys;
  "sext-creds.auth.age".publicKeys = userKeys ++ hostKeys;

  # User account passwords.
  "vale-password.age".publicKeys = userKeys ++ hostKeys;
}
