# nix-config
My nix config

## Screenshots
![desktop screenshot with kitty terminal using fastfetch](./theming/screenshot1.png?raw=true)


## Programs used
Shell: fish
Terminal: kitty + Starship
WM: Umbriel
File manager: Luciole (Noctalia)

## Overview
This Nix configuration manages both NixOS (abeeNix) and nix-darwin (BabeeMac) systems using Home Manager.
It also manages all my containers and VM with NixOS on Proxmox.

### Hosts
- **abeeNix**: NixOS system with Umbriel desktop environment
- **BabeeMac**: nix-darwin system (not actively configured in this repo)
- **glance**: NixOS LXC container with the Glance dashboard application deployed in Proxmox.

### Modules Structure
- **Terminal**: fish shell, starship prompt, zoxide, eza, fd, fzf, jq, git, ssh, neovim, btop, fastfetch
- **Programs**: kitty terminal, zen-browser, luciole, vesktop, obs-studio, obsidian
- **Services**: rsync-backups, cliphist
- **Desktop**: Umbriel desktop environment, Noctalia shell
- **Theming**: stylix theming
- **Development**: k9s, lazygit, talosctl, kompose, kubectl, kubernetes-helm, ansible, openvpn, dnsutils, openssl, inetutils
- **Gaming**: steam, 1password, lact, xivlauncher-rb
- **Media**: Various media tools
- **Security**: 1password integration

## Commands to remember:
### For desktop
```bash
# Update flakes 
sudo nix flake update --flake ~/nix-config/

# Rebuild nixos config: 
sudo nixos-rebuild switch --flake ~/nix-config/

# home-manager config: 
home-manager switch --flake ~/nix-config
```

### For Servers
```bash
# For first configuration, before username is created.
## If using secrets, run and get the age1 key to add to .sops.yaml
ssh-keyscan <IP> 2>/dev/null | ssh-to-age 

nixos-rebuild test --flake .#glance --target-host root@<container-ip> --build-host localhost
nixos-rebuild switch --flake .#glance --target-host root@<container-ip> --build-host localhost

# Afterwards
nixos-rebuild switch --flake .#glance --target-host abee@<container-ip> --build-host localhost --sudo

```

## Inspirations
https://github.com/AlexNabokikh/nix-config for how to setup a modular nixos repository
https://github.com/0thElement/nixconf for inspiration for AGS integration
