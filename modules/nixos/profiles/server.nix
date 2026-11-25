{ pkgs, username, ... }:
{
  imports = [ ./base.nix ];

  security.sudo.wheelNeedsPassword = false;
  nix.settings.trusted-users = [
    "root"
    username
  ];

  environment.systemPackages = with pkgs; [ dnsutils ];
}
