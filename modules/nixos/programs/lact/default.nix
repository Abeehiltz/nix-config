{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.lact ];
  services.lact.enable = true;
}
