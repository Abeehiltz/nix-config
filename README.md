# nix-config
My nix config

## Screenshots
TODO
![desktop screenshot with kitty terminal using fastfetch](./theming/screenshot1.png?raw=true)


## Programs used
Shell: fish
Terminal: kitty + Starship
WM: Umbriel
File manager: Luciole (Noctalia)

## Overview
This Nix configuration manages both NixOS (abeeNix) and nix-darwin (BabeeMac) systems using Home Manager.

### Hosts
- **abeeNix**: NixOS system with Umbriel desktop environment
- **BabeeMac**: nix-darwin system (not actively configured in this repo)

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

## Inspirations
https://github.com/AlexNabokikh/nix-config for how to setup a modular nixos repository
https://github.com/0thElement/nixconf for inspiration for AGS integration
