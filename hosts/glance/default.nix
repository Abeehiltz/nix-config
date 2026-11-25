{
  modulesPath,
  nixosModules,
  hostname,
  ...
}:
{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
    "${nixosModules}/server"
  ];
  services.fstrim.enable = false;

  networking.hostName = hostname;
  nixpkgs.hostPlatform = "x86_64-linux";

  # Copy the exact value from the container's /etc/nixos/configuration.nix
  system.stateVersion = "25.11";

  services.glance = {
    enable = true;
    openFirewall = true;
    settings = {
      server = {
        host = "0.0.0.0"; # default is localhost only
        port = 8080;
      };
      pages = [
        {
          name = "Home";
          columns = [
            {
              size = "full";
              widgets = [ { type = "calendar"; } ];
            }
          ];
        }
      ];
    };
  };
}
