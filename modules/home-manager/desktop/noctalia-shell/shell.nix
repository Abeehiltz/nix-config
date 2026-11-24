{ username, ... }:
{
  programs.noctalia.settings.shell = {
    avatar_path = "/home/${username}/.avatar";
    #    font_family = "DejaVu Sans Mono";
    niri_overview_type_to_launch_enabled = true;
    setup_wizard_enabled = false;
    launch_apps_as_systemd_services = true;
    settings_window_translucent = true;

    greeter_sync.auto_sync = true;
    external_ip_enabled = true;

    umbriel_audio_provider_enabled = true;
    umbriel_overview_close_on_launch_enabled = true;
    umbriel_overview_type_to_launch_enabled = true;

    panel = {
      open_near_click_control_center = true;
      session_placement = "floating";
    };

    screenshot = {
      save_to_file = true;
      directory = "/home/${username}/Pictures/Screenshots/";
      remember_last_region = true;
      region_modifier = "shift";
    };
  };
}
