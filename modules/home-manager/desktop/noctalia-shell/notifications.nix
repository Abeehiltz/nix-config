{
  programs.noctalia.settings = {
    notification = {
      filter_order = [ "filter" ];

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

    # Which OSD popup kinds (volume/brightness/etc.) are enabled.
    osd.kinds = {
      bluetooth = false;
      brightness = false;
      caffeine = false;
      keyboard_backlight = false;
      media = false;
      wifi = false;
    };
  };
}
