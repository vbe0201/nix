# Modules

Reusable Nix modules for defining functionality on host systems.

## Components

### `desktop`

`mine.desktop.enable` sets up the requirements for a full-fledged
Desktop Environment on the system. This includes the latest Linux
kernel, PipeWire audio, X11/Wayland windowing, Bluetooth, and
printing support.

This setup is universal and shared between all supported desktops:

- KDE: `mine.desktop.kde.enable = true;`

### `docker`

`mine.docker.enable` sets up virtualisation and rootless Docker.

### `flatpak`

`mine.flatpak.enable` enables the flatpak service.

### `gaming`

`mine.gaming.enable` provides Steam, Wine, Lutris, Bottles and
Heroic for Linux gaming.

### `hardware`

Specialized modules to support certain hardware of my machines.

`mine.hardware.nvidiaGPU.enable` sets up the proprietary NVIDIA driver for GPU
support. The latest driver will be installed by default, but this
can be customized on demand.

Setting `mine.hardware.tpm.enable` enables support for TPM2 on
eligible devices.

Setting `mine.hardware.udev.switchRcm.enable` installs a udev
rule which allows non-root users to access the Nintendo Switch
console in RCM mode via USB.

### `locale`

`mine.locale.enable` configures my language and time preferences.
Namely, timezone `Europe/Berlin` and German language throughout
the entire system.

### `localsend`

Install the [LocalSend](https://localsend.org/) application and
open firewall ports for it with `mine.localsend.enable`.

### `networking`

`mine.networking.enable` installs my default networking profile
based on NetworkManager with 1.1.1.1 DNS servers and support
for m-DNS resolution.

Additionally, an OpenSSH server is set up to allow remote login
from any of my host into other reachable machines.

`mine.networking.avahi.enable` enables the Avahi service and makes
the machine advertise itself on the network so it can be discovered.

### `nix`

This module sets up the configuration preferences for nixpkgs, and
the Nix daemon itself. These settings will always be enabled.

`mine.nix.nix-ld.enable` enables `nix-ld`, which allows unpatched
dynamic binaries to function properly. A wide range of popular
libraries will be supported by this as well.

### `openrgb`

`mine.openrgb.service.enable` enables the OpenRGB server process in
the background, along with I2C support in the kernel.

`mine.openrgb.program.enable` installs the OpenRGB application and
makes a desktop icon for it.

It is recommended to always enable both options when OpenRGB is
desired unless you have a specific reason not to.

### `openvpn`

OpenVPN client profiles which can be enabled conditionally:

- `mine.openvpn.sext.enable`

Start with:

`sudo systemctl start openvpn-<name>.service`

Stop with:

`sudo systemctl stop openvpn-<name>.service`

### `yubikey`

`mine.yubikey.enable` enables YubiKey hardware support, sudo login
by physical key touch, and installs useful applications for key
management.

### `zsh`

`mine.zsh.enable` sets up ZSH as the system-wide default shell for
all users.

This complements the zsh home-manager configuration; both should
be enabled.

## Useful links

- [NixOS Wiki](https://nixos.wiki)

- [`NixOS/nixos-hardware`](https://github.com/NixOS/nixos-hardware)
