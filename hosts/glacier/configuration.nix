{
  config,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  powerManagement.cpuFreqGovernor = "performance";

  boot = {
    tmp = {
      useTmpfs = true;
      tmpfsSize = "95%";
      cleanOnBoot = true;
    };

    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];
    initrd.kernelModules = [];

    kernelModules = ["kvm-amd"];
    extraModulePackages = [config.boot.kernelPackages.v4l2loopback];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    supportedFilesystems = ["ntfs"];
  };

  hardware.cpu.amd.updateMicrocode = true;

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/42993a77-a622-4198-8798-7edf43e59107";
      fsType = "ext4";
      options = ["noatime"];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/CC89-57F0";
      fsType = "vfat";
      options = ["noatime"];
    };
    "/home" = {
      device = "/dev/disk/by-uuid/1a57178b-56c7-4227-ac75-0af59a26671f";
      fsType = "ext4";
      options = ["noatime"];
    };
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/a5acf252-9402-4724-970c-ba3dd5645402";}
  ];

  networking = {
    hostName = "glacier";
    useDHCP = false;
    interfaces.wlp35s0.useDHCP = true;
  };

  mine = {
    desktop = {
      enable = true;
      kde.enable = true;
    };

    docker.enable = true;

    flatpak.enable = true;

    gaming.enable = true;

    hardware = {
      nvidiaGpu.enable = true;
      udev = {
        switchRcm.enable = true;
      };
    };

    locale.enable = true;

    localsend.enable = true;

    networking = {
      enable = true;
      avahi.enable = true;
    };

    nix.nix-ld.enable = true;

    openrgb = {
      service.enable = true;
      program.enable = true;
    };

    openvpn.sext.enable = true;

    yubikey.enable = true;

    zsh.enable = true;
  };

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    version = "580.95.05";
    sha256_64bit = "sha256-hJ7w746EK5gGss3p8RwTA9VPGpp2lGfk5dlhsv4Rgqc=";
    sha256_aarch64 = "sha256-zLRCbpiik2fGDa+d80wqV3ZV1U1b4lRjzNQJsLLlICk=";
    openSha256 = "sha256-RFwDGQOi9jVngVONCOB5m/IYKZIeGEle7h0+0yGnBEI=";
    settingsSha256 = "sha256-F2wmUEaRrpR1Vz0TQSwVK4Fv13f3J9NJLtBe4UP2f14=";
    persistencedSha256 = "sha256-QCwxXQfG/Pa7jSTBB0xD3lsIofcerAWWAHKvWjWGQtg=";
  };
}
