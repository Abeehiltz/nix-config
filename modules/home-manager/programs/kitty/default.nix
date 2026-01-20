{
  inputs,
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
    };
  };
}
