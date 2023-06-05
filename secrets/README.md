# Secrets

Secrets are [age-encrypted](https://github.com/FiloSottile/age) files
which are exposed to the rest of the configuration through `config`.

This setup uses a YubiKey with OpenPGP to decrypt files at system rebuild.

## Editing a secret

`nix run .#edit-secret <secret>.age`

## Rekeying the system

`nix run .#rekey`
