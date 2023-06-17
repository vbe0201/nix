{ config, ... }:
  let
    publicKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP9cKM/d2D1NxvY+C1rO6Ia6Z4hS8a52GJiQo1y2v+BO"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCViqZxkOWaP9R0DgLLbgarWKnN1SjkQcboqK6fqnBNeSDl9dcKvmqi6nBSSHCGOkKPdlzZtN17CmRzbMFqU4honvEjA5LmeC1q8bS11xz2DDcjR94xX31DSr933aO/T8GJVO0t04j7kJrpEuK+LyeQuPDgAJKbge6x+s7aXp/nuHbmfPTogUpMKJdDiM7SWfhgIAQkCWqo7kcc3xgN7JDWjW418wNjmJdnR9PlPCCJ3ec+xSEuph3cS+N6/IaTTMxSk/PotrIWaGYbMg0XOji/xFn/OzNTME4Bm8+AvN9iywyIZdiNTd26JPMeemXoPIDb8W0pBjK32qHcRrgaVECzXeL4K0/7aOba4yb+m/jZPQwEbhUBgcXXG3mMQp7n376G4TfLT0mezHpUmEQzw+jTO6y4fuFQP2CBmFXE82vu5kD6pZmwoglNPVu+ADdQw3t47DYIkKLHsWTNNXcSMfWxpMalkVprS9mrotLk+fue2rgnBkc/zcIASSfrNSW5Z7M= starr@starrnix"
    ];

  in {
    # Create the default `vale` user.
    users.users.vale = {
      isNormalUser = true;
      home = "/home/vale";
      passwordFile = config.age.secrets.vale_password.path;

      extraGroups = [
        "networkmanager"
        "wheel"
      ];

      openssh.authorizedKeys.keys = publicKeys;
    };

    boot.initrd.network.ssh.authorizedKeys = publicKeys;
  }
