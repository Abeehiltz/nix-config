{ config, pkgs, ... }
:
{
  programs.niri.settings = {
    window-rules = [
      {
        matches = [{}];
        geometry-corner-radius = {
          top-left = 10.0;
          top-right = 10.0;
          bottom-left = 10.0;
          bottom-right = 10.0;
        };
        clip-to-geometry = true;
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
        matches = [ { namespace = "^noctalia-overview*"; } ];
        place-within-backdrop = true;
      }
    ];
  };
}
