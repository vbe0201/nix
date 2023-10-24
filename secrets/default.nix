{...}: {
  age.secrets."3ds_aes_keys".file = ./3ds-aes-keys.age;
  age.secrets.sext_ovpn.file = ./sext.ovpn.age;
  age.secrets.sext_creds.file = ./sext-creds.auth.age;
  age.secrets.vale_password.file = ./vale-password.age;
}
