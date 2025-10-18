{innputs, ...}
:
{
  imports = [
    ./monitor.nix
    ./programs.nix
    ./binds.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

  }; 
}
