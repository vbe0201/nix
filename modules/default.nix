{config, ...}: let
  keys = import ../ssh-keys.nix;
  hostPublicKeys = [
    keys.glacier.host
    keys.spin.host
  ];
in {
  imports = [
    ./desktop
    ./docker
    ./gaming
    ./hardware
    ./locale
    ./localsend
    ./networking
    ./nix
    ./openrgb
    ./openvpn
    ./yubikey
    ./zsh
  ];

  # This value must not be touched at any time.
  system.stateVersion = "22.11";

  # Create the default `vale` user.
  users.users.vale = {
    isNormalUser = true;
    home = "/home/vale";
    hashedPasswordFile = config.age.secrets.vale_password.path;

    extraGroups = [
      "dialout"
      "wheel"
      "wireshark"
    ];

    openssh.authorizedKeys.keys = hostPublicKeys;
  };

  security = {
    # sudo-rs is a drop-in replacement for traditional sudo with the
    # benefit of being written in Rust. It has been audited and aims
    # to prevent the memory safety issues sudo has suffered from.
    sudo-rs.enable = true;
    # Allow using SSH keys to authenticate when in a remote connection.
    pam.sshAgentAuth.enable = true;
  };
}
