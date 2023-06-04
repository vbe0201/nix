# Modules

Reusable Nix modules for defining functionality on host systems.

## Components

### `core`

Universally useful modules, included on all machines by default.

This includes basic system and user configurations, which is
desirable everywhere.

### `desktop`

Isolates minimally functional desktop environment setups for
plug and play experience.

### `hw`

Implements support for specific hardware that I use.

Systems are supposed to include the specific pieces they need.

### `vpn`

OpenVPN client profiles to choose from on a per-system basis.

Start with:

`sudo systemctl start openvpn-<name>.service`

Stop with:

`sudo systemctl stop openvpn-<name>.service`

## Useful links

- [NixOS Wiki](https://nixos.wiki)

- [`NixOS/nixos-hardware`](https://github.com/NixOS/nixos-hardware)
