{
  modulesPath,
  pkgs,
  ...
}: {
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

    kernelModules = ["kvm-amd" "v4l2loopback"];
    extraModulePackages = [pkgs.linuxPackages.v4l2loopback];

    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    supportedFilesystems = ["ntfs"];
  };

  hardware.cpu.amd.updateMicrocode = true;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/42993a77-a622-4198-8798-7edf43e59107";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/CC89-57F0";
    fsType = "vfat";
  };
  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/7edab4b6-ed9a-482a-8ab8-d9476342fea0";
    fsType = "ext4";
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/a5acf252-9402-4724-970c-ba3dd5645402";}
  ];

  networking = {
    hostName = "glacier";

    useDHCP = false;
    interfaces.wlp35s0.useDHCP = true;
  };
}
