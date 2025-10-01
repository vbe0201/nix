# Hosts

This subdirectory is responsible for defining NixOS host systems.

## Instructions

To add a new machine, create a subdirectory with the same files as
other subdirectories and populate `default.nix` accordingly.

In `configuration.nix`, the NixOS system configuration can be done
and suitable modules should be enabled on demand.

In `home.nix`, the home-manager modules can be enabled as needed
and any system-specific configuration may be performed.

Lastly, add an entry for the machine to `hosts/default.nix` and
you're good to go.

> NOTE: If the machine uses a yet unmentioned `system` string, it must
> also be added to `forEachSystem` in [`flake.nix`](../flake.nix).

## Machines

### `glacier`

> AMD Ryzen 1700, 16GB RAM, NVIDIA GeForce GTX 1070, NVME SSD

Glacier is my desktop PC and my daily driver for just about anything.

### `spin`

> Acer Spin 5 SP513-55N, Intel Core i7-1165G7, 16GB RAM, Intel Iris Xe, NVME SSD

My laptop when I'm out and about.
