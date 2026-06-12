{...}:
{
  programs.noctalia.settings.theme = {
    mode = "dark";
    source = "wallpaper";
    wallpaper_scheme = "vibrant";

    templates = {
      enable_builtin_templates = true;
      enable_community_templates = true;
      
      builtin_ids = [ "niri" "gtk3" "gt4" "qt" "kitty" "starship"];
      community_ids = ["zen-browser" "neovim" "obsidian" "discord" "steam" "yazi"];
    };
  };
}
