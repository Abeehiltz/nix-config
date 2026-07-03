{...}:
{
  programs.noctalia.settings.bar = {

    main = {
      border_width = 1;
      #background_opacity = 0.5;
      margin_ends = 15;
      margin_edge = 5;
      #radius_top_left = 0;
      #radius_top_right = 0;
      start = [ "clock" "launcher" "spacer" "taskbar" "audio_visualizer" ];
      center = [ "workspaces" ];
      end = [ "tray" "notifications" "volume" "control-center" "session" ];
    };
  };

  programs.noctalia.settings.widget= {
    taskbar = {
      group_by_workspace = true;
      hide_empty_workspaces = true;
      group_single_icon_per_app = true;
    };
  };
}
