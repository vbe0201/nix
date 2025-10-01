{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  imports = [
    ./kde.nix
  ];

  options.mine.desktop = {
    enable = mkEnableOption "Desktop machine essentials";
  };

  config = mkIf config.mine.desktop.enable {
    # We want to be on the latest stable kernel by default. The
    # one in unstable may be even more recent, but has given me
    # headache with NVIDIA drivers and kernel modules before.
    boot.kernelPackages = mkDefault pkgs.linuxPackages_latest;

    # Set up audio. I prefer PipeWire, with rtkit allowing it
    # to use the realtime scheduler for increased performance.
    security.rtkit.enable = true;
    services = {
      pulseaudio.enable = false;

      pipewire = {
        enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
        jack.enable = true;
        pulse.enable = true;
        wireplumber.enable = true;
      };
    };

    users.users.vale.extraGroups = ["audio"];

    environment.systemPackages = with pkgs; [
      pavucontrol
      pulsemixer
      playerctl
    ];

    # Enable Wayland/X11 windowing system.
    # Yes, this is for both. Do not disable.
    services.xserver = {
      enable = true;
      xkb.layout = mkDefault "eu";
      wacom.enable = mkDefault false;
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable Bluetooth support.
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
          FastConnectable = mkDefault true;
        };

        Policy = {
          AutoEnable = true;
        };
      };
    };
  };
}
