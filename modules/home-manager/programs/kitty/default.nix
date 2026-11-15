{
  pkgs,
  ...
}:
{
  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    shellIntegration.enableFishIntegration = true;
    font.name = "FiraCode Nerd Font";

    settings = {
      shell = "${pkgs.fish}/bin/fish";
      background_opacity = 0.9;
      background_blur = 1;
    };

    extraConfig = ''
      include themes/noctalia.conf
    '';

  };

}
