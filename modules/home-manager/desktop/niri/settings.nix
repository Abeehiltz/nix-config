{ config, pkgs, ... }
:
{
  programs.niri = {
    enable = true;
    package = pkgs.niri;

    settings = {
      prefer-no-csd = true;

      input = {
        workspace-auto-back-and-forth = true;
        keyboard.xkb.layout = "us";
        mouse = {
          left-handed = true; # thanks to lift left I need to use this.
          accel-profile = null;
        };
      };
      outputs = {
        "DP-3" = {
          mode = {
            width = 3840;
            height = 2160;
            refresh = 240.0;
          };
          scale = 1.5;
          position = { x = 2560; y = 0; };
          focus-at-startup = true;
        };
        "DP-1" = {
          mode = {
            width = 2560;
            height = 1440;
            refresh = 119.998;
          };
          scale = 1;
          position = { x = 0; y = 0; };
        };
      };
      environment = {
        XDG_SESSION_TYPE = "wayland";
        XDG_CURRENT_DESKTOP = "niri";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        QT_QPA_PLATFORM = "wayland";
      };
    };
  };
}
