## Overview
Nix flake managing NixOS (abeeNix) and nix-darwin (BabeeMac) with Home Manager.
Active desktop: Umbriel. Niri and Hyprland modules exist but are inactive.
Shell is Fish, use proper commands to match this.
when using commands taking a path in parameters, make sure you start the path with "./" for current directory.

## Layout
- hosts/<host>/: system config per machine (abeeNix = NixOS, BabeeMac = nix-darwin)
- home/abee/<host>/: Home Manager entry point per host; imports profiles
- modules/home-manager/: user-level modules, grouped by category, composed by profiles/
- modules/nixos/, modules/darwin/: system-level modules
- pkgs/: custom packages (flat `pkgs/<name>/`, not by-name)
- theming/: static assets

## Commands
- Build: `nixos-rebuild build --flake .#abeeNix`
- Check: `nix flake check`
- Format one file: `nix fmt PATH_TO_FILE`
- Format all (using fish): `find . -name '*.nix' -not -path './.git/*' | while read -l f; nix fmt --quiet $f; end`
- Do NOT run `switch` or `sudo` commands; ask the user.
can't be built on abeeNix; don't try

## Conventions
- Formatter: nixfmt (nixfmt-rs)
- Home Manager modules are plain modules in `modules/home-manager/<category>/<name>/default.nix`.
  They have NO custom options and no `mkEnableOption`. A module is enabled by importing it
  from a profile in `modules/home-manager/profiles/`.
- Platform checks: use `pkgs.stdenv.hostPlatform.isDarwin` / `isLinux` (see terminal/ssh).
- Prefer Home Manager's `programs.<name>` / `services.<name>` options over `home.packages` + `xdg.configFile`.
- Modules that need an upstream Home Manager module import it themselves
  (e.g. terminal/nvim imports `inputs.nvf.homeModules.default`).
- Shared code goes in modules/, host-specific code in hosts/<name>/ or home/abee/<host>/.

## Rules
- `git add` new files before evaluating
- Never touch hardware-configuration.nix, stateVersion, or secrets
- Keep NixOS-only and Darwin-only options separate
- Update the README whenever you add, remove, or move a module, or change the desktop, shell, or file manager.
- Never run nix flake update or bump inputs unless asked.
- Don't add new flake inputs without asking.
- Verification before claiming done: Report what you actually ran. If a build wasn't run, say so.
- Before a non-trivial change, find how nixpkgs or the upstream project does it and follow that shape. pkgs/ is flat, but use nixpkgs by-name conventions for package contents.
- Don't enable new modules on hosts unprompted.
- Do not leave this folder unless clearly specified.
- After editing any .nix file, do a config check and format the file with the format command.

## How to add an application
Adding an app does NOT mean creating a module. Decide in this order, stop at the first match:

1. Use the nixos MCP (mcp-nixos) to search Home Manager options for `programs.<name>`
   and `services.<name>`. Do not guess from memory.
2. If it exists, create a module (steps below).
3. If it does NOT exist, do not create a module. Add `pkgs.<name>` to a
   `home.packages` list in the best-fitting profile in `modules/home-manager/profiles/`
   (`desktop.nix` for GUI apps, `dev.nix` for dev tools, etc.). One line, no new file.
4. Only create a custom package in `pkgs/` if it isn't in nixpkgs at all.

Report which path you took and why (e.g. "no programs.foo option, added to desktop.nix").

### Module steps (only when programs.<name> exists)
1. Choose the category under `modules/home-manager/`:
   - `terminal/`: CLI tools and shell setup
   - `programs/`: GUI apps
   - `services/`: user services and timers
   - `desktop/`: compositor and shell pieces
   - `theming/`: stylix and visual config
2. Create `<category>/<name>/default.nix`. Copy the shape of a sibling
   (e.g. `terminal/ssh`, `programs/kitty`).
3. Import it from the matching profile in `modules/home-manager/profiles/` with a relative path
   (`../terminal/<name>`):
   - `base.nix`: needed everywhere, including Darwin
   - `desktop.nix`: GUI/desktop apps
   - `dev.nix`, `gaming.nix`, `media.nix`, `onepassword.nix`: topic-specific
   If no profile fits, ask before importing it from a host or home file.
4. If a profile is shared with BabeeMac, guard Linux-only config with
   `lib.mkIf pkgs.stdenv.hostPlatform.isLinux`.
5. Packages not in nixpkgs go in `pkgs/<name>/default.nix` and must be exposed through the
   flake's `packages` output (see how `ani2xcur` is wired).
6. `git add` new files, format, `nix flake check`, then `nixos-rebuild build --flake .#abeeNix`.



## How to write readme
- Write down the active desktop, file manager, shell
- Explain the layout of this project so a new user can quickly understand where to find configurations.
- Assume the audience is relatively new to nix configuration and nixOs.
- Don't document options or hosts that don't exist; verify against the repo.
- Keep it under ~60 lines; link to directories instead of listing every module, since lists go stale.
