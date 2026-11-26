{
  modulesPath,
  nixosModules,
  hostname,
  config,
  ...
}:
let
  jellyfin = "https://jellyfin.abeehiltz.com";
  kavita = "https://mangas.abeehiltz.com";
  pageArgs = { inherit jellyfin kavita; };
in
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

  # SECRET MANAGEMENT
  sops = {
    defaultSopsFile = ../../secrets/glance.yaml;

    secrets.jellyfin_api_key = { };
    secrets.kavita_api_key = { };

    templates."glance.env" = {
      content = ''
        JELLYFIN_API_KEY=${config.sops.placeholder.jellyfin_api_key}
        KAVITA_API_KEY=${config.sops.placeholder.kavita_api_key}
      '';
      restartUnits = [ "glance.service" ];
    };
  };

  # Glance config
  services.glance = {
    enable = true;
    openFirewall = true;
    environmentFile = config.sops.templates."glance.env".path;
    settings = {
      server = {
        host = "0.0.0.0"; # default is localhost only
        port = 8080;
      };
      theme = {
        background-color = "240 21 15";
        primary-color = "267 84 81";
        positive-color = "115 54 76";
        negative-color = "347 70 65";
        contrast-multiplier = 1.2;
      };

      pages = map (page: import page pageArgs) [
        ./pages/home.nix
        ./pages/media.nix
      ];
    };
  };
}
