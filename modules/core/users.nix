{config, ...}: let
  keys = import ../../ssh-keys.nix;
  publicKeys = [
    keys.glacier.host
    keys.spin.host
  ];

in {
  # Create the default `vale` user.
  users.users.vale = {
    isNormalUser = true;
    home = "/home/vale";
    hashedPasswordFile = config.age.secrets.vale_password.path;

    extraGroups = [
      "networkmanager"
      "wheel"
      "wireshark"
    ];

    openssh.authorizedKeys.keys = publicKeys;
  };

  boot.initrd.network.ssh.authorizedKeys = publicKeys;
}
