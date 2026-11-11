{
  programs.umbriel = {
    enable = true;

    settings = {
      input = {
        keyboard.layout = "us";
        mouse.accel_profile = "flat";
      };
      output = {
        "Microstep MPG322UX OLED 0x01010101" = {
          mode = "3840x2160@199.999";
          scale = 1.5;
          position = [
            2560
            0
          ];
        };
        "Acer Technologies XB271HU A #ASO7TBPV1Ovd" = {
          mode = "2560x1440@59.951";
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
