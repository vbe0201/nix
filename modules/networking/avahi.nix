{
  config,
  lib,
  ...
}:
with lib; {
  options.mine.networking.avahi = {
    enable = mkEnableOption "Avahi m-DNS discovery";
  };

  config = mkIf config.mine.networking.avahi.enable {
    services.avahi = {
      enable = true;

      openFirewall = true;
      nssmdns4 = true;
      ipv4 = true;
      ipv6 = true;

      publish = {
        enable = true;
        addresses = true;
        workstation = true;
        domain = true;
        userServices = true;
        hinfo = true;
      };
    };
  };
}
