{ config, pkgs, inputs, ...}
:
{
  imports = [
    inputs.niri-flake.homeModules.niri
    ./settings.nix
    ./keybinds.nix
    ./autostart.nix
    ./windows-rules.nix
  ];
}
