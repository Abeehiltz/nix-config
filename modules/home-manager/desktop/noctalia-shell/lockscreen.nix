# One login-box widget per output (DP-3, DP-5) plus a fallback for the
# nested/windowed "winit" backend used when testing in a window. Adjust
# cx/cy/output to match your own monitor layout - these values are
# specific to the machine this config came from.
let
  # All three login boxes share the same visual style.
  loginBoxStyle = {
    background_color = "surface_variant";
    background_opacity = 0.88;
    background_radius = 12.0;
    center_password_text = false;
    input_opacity = 1.0;
    input_radius = 6.0;
    layout = "regular";
    show_caps_lock = true;
    show_keyboard_layout = true;
    show_login_button = true;
    show_media = true;
    show_session_buttons = true;
    show_unlock_hint = true;
    show_weather = true;
  };

  # Builds one `login_box` widget entry; only geometry/output differ
  # between monitors.
  mkLoginBox =
    {
      output,
      cx,
      cy,
      boxWidth ? 810.0,
      boxHeight ? 196.0,
      placementWidth ? 2560.0,
      placementHeight ? 1440.0,
    }:
    {
      type = "login_box";
      inherit output cx cy;
      box_width = boxWidth;
      box_height = boxHeight;
      placement_width = placementWidth;
      placement_height = placementHeight;
      rotation = 0.0;
      settings = loginBoxStyle;
    };
in
{
  programs.noctalia.settings.lockscreen_widgets = {
    enabled = false;
    schema_version = 2;

    widget_order = [
      "lockscreen-login-box@winit"
      "lockscreen-login-box@DP-5"
      "lockscreen-login-box@DP-3"
    ];

    grid = {
      cell_size = 16;
      major_interval = 4;
      visible = true;
    };

    widget = {
      "lockscreen-login-box@DP-3" = mkLoginBox {
        output = "DP-3";
        cx = 1280.0;
        cy = 1317.0;
      };

      "lockscreen-login-box@DP-5" = mkLoginBox {
        output = "DP-5";
        cx = 1280.0;
        cy = 1317.0;
      };

      "lockscreen-login-box@winit" = mkLoginBox {
        output = "winit";
        cx = 960.0;
        cy = 1960.0;
        placementWidth = 0.0;
        placementHeight = 0.0;
      };
    };
  };
}
