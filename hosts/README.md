# Hosts

This subdirectory is responsible for defining NixOS host systems.

## Instructions

To add a new machine, create `<hostname>.nix` with a minimal hardware
configuration necessary. Take inspiration from existing files.

Then add the new machine to `default.nix` with all the modules to
set it up with.

> NOTE: If the machine uses a yet unmentioned `system` string, it must
> also be added to `forEachSystem` in [`flake.nix`](../flake.nix).

## Machines

### `glacier`

> AMD Ryzen 1700, 16GB RAM, NVIDIA GeForce GTX 1070, NVME SSD

Glacier is my desktop PC and my daily driver for just about anything.
