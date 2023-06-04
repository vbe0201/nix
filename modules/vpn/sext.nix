{ config, pkgs, ... }: {
  services.openvpn.servers.sext = {
    config = '' config ${config.age.secrets.sext_ovpn.path} '';
    autoStart = false;
  };
}
