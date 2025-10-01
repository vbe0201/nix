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
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/CC89-57F0";
      fsType = "vfat";
    };
    "/home" = {
      device = "/dev/disk/by-uuid/7edab4b6-ed9a-482a-8ab8-d9476342fea0";
      fsType = "ext4";
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
}
