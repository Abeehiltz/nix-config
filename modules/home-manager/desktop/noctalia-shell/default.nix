{
  imports = [
    ./bar.nix
    ./control-center.nix
    ./desktop.nix
    ./dock.nix
    ./lockscreen.nix
    ./notifications.nix
    ./services.nix
    ./theming.nix
    ./shell.nix
  ];

  programs.noctalia.enable = true;

}
