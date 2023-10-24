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
      "xhci_pci"
      "thunderbolt"
      "vmd"
      "nvme"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];
    initrd.kernelModules = [];

    kernelModules = ["kvm-intel"];
    extraModulePackages = [];

    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    kernelPackages = pkgs.unstable.linuxPackages_latest;
  };

  hardware.cpu.intel.updateMicrocode = true;

  powerManagement.cpuFreqGovernor = "powersave";

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/960337f3-b8d2-4e27-a316-5e8c20b88c6b";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/F1B0-72F4";
    fsType = "vfat";
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/87cebc14-a9ee-4957-b43a-59c98ce7dc3d";}
  ];

  networking = {
    hostName = "spin";

    useDHCP = false;
    interfaces.wlp0s20f3.useDHCP = true;
  };
}
