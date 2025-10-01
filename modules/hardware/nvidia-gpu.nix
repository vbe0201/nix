{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.mine.hardware.nvidiaGpu = {
    enable = mkEnableOption "NVIDIA GPU support";
  };

  config = mkIf config.mine.hardware.nvidiaGpu.enable {
    # Make sure nouveau never runs alongside the official driver.
    boot.blacklistedKernelModules = ["nouveau"];

    # Configure the video driver to use on Wayland and X11.
    services.xserver.videoDrivers = ["nvidia"];

    # Enable Vulkan support.
    environment.systemPackages = with pkgs; [
      vulkan-loader
      vulkan-validation-layers
      vulkan-tools
    ];

    # Recommended environment variables.
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };

    # Hardware configuration for GPUs.
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [nvidia-vaapi-driver];
      };

      nvidia = {
        package = mkDefault config.boot.kernelPackages.nvidiaPackages.latest;
        open = false;
        nvidiaSettings = true;
        modesetting.enable = true;
      };
    };
  };
}
