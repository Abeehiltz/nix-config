{
  programs.noctalia.settings = {
    osd = {
      #background_opacity = 0.95;

      # Which OSD popup kinds (volume/brightness/etc.) are enabled.
      kinds = {
        bluetooth = false;
        brightness = false;
        caffeine = false;
        keyboard_backlight = false;
        media = false;
        wifi = false;
      };
    };
    notification = {
      #background_opacity = 0.95;
      filter_order = ["filter"];

      filter.filter = {
        enabled = true;
        match = "vesktop";
        allow_permanent = false;
        bypass_dnd = false;
        play_sound = true;
        save_history = false;
        show_toast = true;
      };
    };
  };
}
