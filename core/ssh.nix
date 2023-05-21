## Enables SSH access to NixOS machines.
{ ... }: {
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    challengeResponseAuthentication = false;
    kbdInteractiveAuthentication = false;
    permitRootLogin = "no";

    extraConfig = ''
      AllowAgentForwarding no
      AllowStreamLocalForwarding no
      AuthenticationMethods publickey
    '';
  };
}
