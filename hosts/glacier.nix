{ config, modulesPath, pkgs, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    tmp = {
      useTmpfs = true;
      tmpfsSize = "75%";
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
    extraModulePackages = [];

    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    supportedFilesystems = ["ntfs"];

    kernelPackages = pkgs.unstable.linuxPackages_latest;
  };

  hardware.cpu.amd.updateMicrocode = true;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/182bb213-c166-4288-8065-8d20378acf88";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/DB14-A397";
    fsType = "vfat";
  };
  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/7edab4b6-ed9a-482a-8ab8-d9476342fea0";
    fsType = "ext4";
  };

  swapDevices = [];

  networking = {
    hostName = "glacier";

    useDHCP = false;
    interfaces.wlp35s0.useDHCP = true;
  };
}
