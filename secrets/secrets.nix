let
  keys = import ../ssh-keys.nix;

  hostKeys = [keys.glacier.host keys.spin.host];
  userKeys = [keys.glacier.vale keys.spin.vale];

in {
  # System-specific 3DS AES keys.
  "3ds-aes-keys.age".publicKeys = userKeys ++ hostKeys;

  # User account passwords.
  "vale-password.age".publicKeys = userKeys ++ hostKeys;
}
