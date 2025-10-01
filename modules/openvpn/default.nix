{
  config,
  lib,
  ...
}:
with lib; {
  options.mine.openvpn = {
    sext.enable = mkEnableOption "s-ext client configuration";
  };

  config = mkIf config.mine.openvpn.sext.enable {
    services.openvpn.servers.sext = {
      config = ''
        config ${config.age.secrets.sext_ovpn.path}
        auth-user-pass ${config.age.secrets.sext_creds.path}
      '';
    };
  };
}
