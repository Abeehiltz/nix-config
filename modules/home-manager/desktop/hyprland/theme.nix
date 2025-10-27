{...}:
{
  wayland.windowManager.hyprland.settings = {
    source = "~/.config/hypr/colors-hyprland.conf"; # Wallust colors generated
    general = {
      gaps_in = 5;
      gaps_out = 10;
      border_size = 2;
      layout = "dwindle";
      resize_on_border = true;
      # allow_tearing = true;
    };

    decoration = {
      rounding = 10;
      active_opacity = 1.0;
      inactive_opacity = 1.0;
      dim_special = 0.15;

      blur = {
        enabled = true;
        special = true; # Blurs spexial workspace
        new_optimizations = true;
        # Good settings, but zen is not readable when fully transparent
        size = 2;
        passes = 4;
        # passes = 3;
        vibrancy = 0.1696;

        # ignore_opacity = true;
        # xray = false;
      };

      shadow = {
        enabled = true;
        range = 12;
        render_power = 5;
      };

    };
  };
}
