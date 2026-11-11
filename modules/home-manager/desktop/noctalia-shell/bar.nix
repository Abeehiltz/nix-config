{
  programs.noctalia.settings = {
    bar.main = {
      background_opacity = 0.95;
      border_width = 1;
      margin_edge = 5;
      margin_ends = 15;

      start = [
        "clock"
        "launcher"
        "spacer"
        "taskbar"
        "audio_visualizer"
      ];
      center = [ "workspaces" ];
      end = [
        "tray"
        "notifications"
        "volume"
        "control-center"
        "session"
      ];

      actions.middle = "none";
    };

    widget.taskbar = {
      group_by_workspace = true;
      group_single_icon_per_app = true;
      hide_empty_workspaces = true;
    };
  };
}
