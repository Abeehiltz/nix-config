{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.umbriel.nixosModules.default
  ];

  programs.umbriel.enable = true;

  services.displayManager.noctalia-greeter = {
    enable = true;
    passwordless-sync-users = [ "abee" ];
    settings = {
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 24;
        path = "${pkgs.bibata-cursors}/share/icons";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    kitty
    wl-clipboard
    xwayland
  ];

}
