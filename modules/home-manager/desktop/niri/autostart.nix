{ lib, config, pkgs, ... }:
{
    programs.niri.settings.spawn-at-startup = [
      { command = ["noctalia"]; }
      { command = ["xwayland-satellite"]; }
      { command = ["vesktop"]; } 
      { command = ["steam"]; }
    ];
}
