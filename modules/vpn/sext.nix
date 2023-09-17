{config, ...}: {
  services.openvpn.servers.sext = {
    config = ''
      config ${config.age.secrets.sext_ovpn.path}
      auth-user-pass ${config.age.secrets.sext_creds.path}
    '';
    autoStart = false;
  };
}
