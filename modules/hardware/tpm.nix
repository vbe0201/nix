{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.mine.hardware.tpm = {
    enable = mkEnableOption "TPM2 support";
  };

  config = mkIf config.mine.hardware.tpm.enable (
    let
      tss = "tss";
      uhid = "uhid";
    in {
      security.tpm2 = {
        enable = true;
        applyUdevRules = true;
        abrmd.enable = true;
        pkcs11.enable = true;
      };

      boot.kernelModules = [uhid];

      users.users.vale.extraGroups = [tss uhid];

      environment.systemPackages = with pkgs; [
        tpm2-tools
        tpm2-tss
        tpm2-abrmd
      ];

      environment.sessionVariables = {
        TPM2TOOLS_TCTI = "device:/dev/tpmrm0";
      };
    }
  );
}
