{ config, pkgs, ... }
:
{
  programs.niri.settings = {
    window-rules = [
      {
        matches = [{}];
        geometry-corner-radius = {
          top-left = 20.0;
          top-right = 20.0;
          bottom-left = 20.0;
          bottom-right = 20.0;
        };
        clip-to-geometry = true;
      }
      {
        matches = [ { app-id="dev.noctalia.Noctalia.Settings"; } ];
        open-floating = true;
        default-column-width = { fixed = 1080; };
        default-window-height = { fixed = 920; };
      }
      {
        matches = [
          {
            app-id = "steam";
            title = "^notificationtoasts_\d+_desktop$";
          }
        ];
        open-focused=false;
        default-floating-position = {
          relative-to = "bottom-right";
          x = 0;
          y = 0;
        };
      }
    ];

    layer-rules = [ 
      {
        matches = [ { namespace="^noctalia-backdrop"; } ];
        place-within-backdrop = true;
      }

    ];

  };
}
