{
  config,
  inputs,
  ...
}:
{
  # xdg.configFile."noctalia/templates/discord-midnight-alpha.css".text = patched;
  programs.noctalia.settings.theme = {
    mode = "dark";
    source = "wallpaper";
    wallpaper_scheme = "vibrant";

    templates = {
      enable_builtin_templates = false;
      enable_community_templates = false;

      builtin_ids = [
        "niri"
        "gtk3"
        "gt4"
        "qt"
        "kitty"
        "umbriel"
      ];

      community_ids = [
        "feishin"
        #        "zen-browser" # Using transparency instead
        "discord"
        "neovim"
        "obsidian"
        "steam"
        "lazygit"
        "yazi"
        "strata"
        "obs"
      ];

      /*
        user.discord_midnight_alpha = {
          input_path = "${config.xdg.configHome}/noctalia/templates/discord-midnight-alpha.css";
          output_path = "${config.xdg.configHome}/vesktop/themes/noctalia-alpha.theme.css";

        };
      */
    };
  };
}
