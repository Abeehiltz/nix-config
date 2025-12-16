{innputs, nhModules, ...}
:
{
  imports = [
    ./monitor.nix
    ./programs.nix
    ./binds.nix
    ./animations.nix
    ./theme.nix

    "${nhModules}/programs/rofi"
    "${nhModules}/programs/wallust"
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = false; # because we use UWSM

  }; 
}
