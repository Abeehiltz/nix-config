{
  programs.umbriel.settings.window_rule = [
    {
      blur = true;
      blur_optimized = true;
    }
    {
      match.app_id = "^dev.noctalia.Noctalia$";
      default_floating = true;
      default_floating_size = {
        width = 0.5;
        height = 0.5;
      };
    }

    # ----- #
    # STEAM #
    # ----- #
    {
      match = {
        app_id = "steam";
        title = ''^notificationtoasts_\d+_desktop$'';
      };
      default_focused = false;
      default_position = {
        x = 10;
        y = 10;
        anchor = "bottom_right";
      };
    }
    # Game opening weird new windows, now open as floating windows instead.
    {
      match = {
        app_id = "^steam_app_.*$";
        title = "Form";
      };

      default_focused = false;
    }
    {
      match = {
        app_id = "steam";
        title = "Steam Big Picture Mode";
      };

      default_focused = true;
      default_fullscreen = true;
      default_workspace = "steam";
    }
    {
      match = {
        app_id = "steam.*";
      }

      ;
      default_workspace = "steam";
    }
    # Discord
    {
      match = {
        app_id = "vesktop";
      };
      default_workspace = "discord";
      default_maximize = true;
    }
    # Picture in Picture
    {
      match.title = "Picture-in-Picture";
      default_floating = true;
      default_floating_size = {
        width = 0.33;
        height = 0.33;
      };
      default_position = {
        x = 10;
        y = 10;
        anchor = "top_right";
      };
    }

  ];

  programs.umbriel.settings.layer_rule = [
    {
      match.namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$";
      blur = true;
      blur_ignore_alpha = 0.6;
      blur_optimized = false;
    }
  ];
}
