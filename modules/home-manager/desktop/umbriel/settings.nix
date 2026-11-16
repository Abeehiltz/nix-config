{
  programs.umbriel = {
    enable = true;

    settings = {
      general.xwayland_primary_output = "Microstep MPG322UX OLED 0x01010101";
      input = {
        keyboard.layout = "us";
        mouse.accel_profile = "flat";
        cursor.theme = "Phoebe";
        cursor.size = 36;
      };
      output = {
        "Microstep MPG322UX OLED 0x01010101" = {
          mode = "3840x2160@119.999";
          scale = 1.5;
          position = [
            2560
            0
          ];
        };
        "Acer Technologies XB271HU A #ASO7TBPV1Ovd" = {
          mode = "2560x1440@119.998";
          scale = 1;
          position = [
            0
            0
          ];
        };
      };
      environment = {
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        QT_QPA_PLATFORM = "wayland";
        NIXOS_OZONE_WL = "1";
        ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      };

      layout = {
        gap = 6;
        struts = {
          left = 32;
          right = 32;
        };
      };
    };
  };
}
