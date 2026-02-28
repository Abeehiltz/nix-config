{ lib, config, pkgs, ... }:
{
    programs.niri.settings.spawn-at-startup = [
      { command = ["noctalia-shell"]; }
      { command = ["xwayland-satellite"]; }
      { command = ["vesktop"]; } 
    ];
}
