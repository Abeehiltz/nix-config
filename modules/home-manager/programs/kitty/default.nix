{
  inputs,
  ...
}:
{
  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    shellIntegration.enableFishIntegration = true;

    font.name = "FiraCode Nerd Font"; 
  };
}
