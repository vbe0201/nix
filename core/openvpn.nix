## OpenVPN configuration with dedicated services for each network.
{ config, pkgs, ... }: {
  services.openvpn.servers = {
    sext = {
      config = '' config ${config.age.secrets.sext_ovpn_config.path} '';
      autoStart = false;
    };
  };
}
