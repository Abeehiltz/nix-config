{innputs, ...}
:
{
  imports = [
    ./monitor.nix
    ./programs.nix
    ./binds.nix
    ./animations.nix
    ./theme.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = false; # because we use UWSM

  }; 
}
