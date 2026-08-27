{
  programs.noctalia.settings = {
    calendar.enabled = true;

    idle = {
      behavior_order = [
        "lock"
        "screen-off"
        "lock-and-suspend"
      ];

      behavior = {
        lock = {
          action = "lock";
          enabled = false;
          timeout = 600.0;
        };
        "screen-off" = {
          action = "screen_off";
          enabled = true;
          timeout = 660.0;
        };
        "lock-and-suspend" = {
          action = "lock_and_suspend";
          enabled = false;
          timeout = 900.0;
        };
      };
    };

    location.address = "Luxembourg, Luxembourg";
  };
}
