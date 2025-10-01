{
  modulesPath,
  pkgs,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  powerManagement = {
    powertop.enable = true;
    cpuFreqGovernor = "powersave";
  };

  boot = {
    tmp = {
      useTmpfs = true;
      tmpfsSize = "75%";
      cleanOnBoot = true;
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

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  hardware.cpu.intel.updateMicrocode = true;

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/960337f3-b8d2-4e27-a316-5e8c20b88c6b";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/F1B0-72F4";
      fsType = "vfat";
    };
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/87cebc14-a9ee-4957-b43a-59c98ce7dc3d";}
  ];

  networking = {
    hostName = "spin";
    useDHCP = false;
    interfaces.wlp0s20f3.useDHCP = true;
  };

  services = {
    logind.lidSwitch = "suspend-then-hibernate";
    upower.enable = true;
    thermald.enable = true;
  };

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=1
  '';

  programs.light.enable = true;
  environment.systemPackages = with pkgs; [powertop];

  mine = {
    desktop = {
      enable = true;
      kde.enable = true;
    };

    hardware = {
      tpm.enable = true;
      udev = {
        switchRcm.enable = true;
      };
    };

    locale.enable = true;

    localsend.enable = true;

    networking.enable = true;

    nix.nix-ld.enable = true;

    openvpn.sext.enable = true;

    yubikey.enable = true;

    zsh.enable = true;
  };
}
