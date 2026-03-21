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
    ];

    layer-rules = [
      {
        matches = [ { namespace = "^noctalia-overview*" } ]
        place-within-backdrop = true;
      }
    ];
  };
}
