{ config, inputs, ... }:
let
  src = builtins.readFile "${inputs.noctalia-templates}/discord/discord-midnight.css";

  patched =
    builtins.replaceStrings
      [
        "--bg-floating: var(--bg-3);"
        "--bg-1: {{colors.surface_container_lowest.default.hex}};"
        "--bg-2: {{colors.surface_container_low.default.hex}};"
        "--bg-3: {{colors.surface_container.default.hex}};"
        "--bg-4: {{colors.surface.default.hex}};"
        "@name Noctalia Midnight"
      ]
      [
        "--bg-floating: {{colors.surface_container.default.hex}}EE;"
        "--bg-1: {{colors.surface_container_lowest.default.hex}}AA;"
        "--bg-2: {{colors.surface_container_low.default.hex}}AA;"
        "--bg-3: {{colors.surface_container.default.hex}}CC;"
        "--bg-4: {{colors.surface.default.hex}}CC;"
        "@name Noctalia Midnight Alpha"
      ]
      src;
in
# Fail the build if upstream renames those lines, instead of silently doing nothing
assert patched != src;
{

  xdg.configFile."noctalia/templates/discord-midnight-alpha.css".text = patched;
  programs.noctalia.settings.theme = {
    mode = "dark";
    source = "wallpaper";
    wallpaper_scheme = "vibrant";

    templates = {
      enable_builtin_templates = true;
      enable_community_templates = true;

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

      user.discord_midnight_alpha = {
        input_path = "${config.xdg.configHome}/noctalia/templates/discord-midnight-alpha.css";
        output_path = "${config.xdg.configHome}/vesktop/themes/noctalia-alpha.theme.css";

      };
    };
  };
}
