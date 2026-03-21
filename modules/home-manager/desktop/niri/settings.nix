{ config, pkgs, ... }
:
{
  programs.niri = {
    enable = true;
    package = pkgs.niri;

    settings = {
      prefer-no-csd = true;

      screenshot-path = "~/Pictures/Screenshots/%Y-%m-%d_%H-%M-%S_Screenshot.png";
     
      input = {
        workspace-auto-back-and-forth = true;
        keyboard.xkb.layout = "us";
        mouse = {
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
            refresh = 59.951;
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
        NIXOS_OZONE_WL = "1";
        ELECTRON_OZONE_PLATFORM_HINT="wayland";
      };

    # To remove when include works through niri-flake
    layout = {
      gaps = 6;

      struts = {
        left = 32;
        right = 32;
      };
      focus-ring = {
        width = 2;
        active   = {color="#e47967";};
        inactive = {color="#231b1a";};
        urgent   = {color="#fd4663";};
      };
    };


    };
  };
}
