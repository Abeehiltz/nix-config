{ username, ...}:
{
  programs.wallust = {
    enable = true;

    settings = {
      backend = "wal";

      check_contrast = true;

      templates = {
        kitty.template = "/home/${username}/nix-config/theming/wallust/templates/colors-kitty.conf";
        kitty.target = "/home/${username}/.config/kitty/kitty-colors.conf";

        hyprland.template = "/home/${username}/nix-config/theming/wallust/templates/colors-hyprland.conf";
        hyprland.target = "/home/${username}/.config/hypr/colors-hyprland.conf";

      };
    };
  };
}
