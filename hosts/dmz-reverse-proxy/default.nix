{
  modulesPath,
  pkgs,
  lib,
  nixosModules,
  hostname,
  config,
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
  system.stateVersion = "26.11";

  # SECRET MANAGEMENT
  sops = {
    defaultSopsFile = ./secrets.yaml;

    secrets.tailscale-authkey = { };
    secrets.caddy-env = { };
  };

  # --- Tailscale ---
  services.tailscale = {
    enable = true;
    authKeyFile = config.sops.secrets.tailscale-authkey.path; # tagged, reusable or one-off key
    useRoutingFeatures = "none";
    extraUpFlags = [
      "--hostname=dmz-proxy"
      "--advertise-tags=tag:dmz-proxy" # must match the tag on the auth key
      "--accept-dns=false" # stop tailscaled fighting over resolv.conf in the container
    ];
  };

  # --- Caddy ---
  services.caddy = {
    enable = true;
    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@v0.2.1" ];
      hash = lib.fakeHash;
    };
    environmentFile = config.sops.secrets.caddy-env.path;

    services.caddy.virtualHosts."*.public.abeehiltz.com".extraConfig = ''
      tls {
        dns cloudflare {env.CF_API_TOKEN}
        resolvers 1.1.1.1
      }

      @jellyfin host jellyfin.public.abeehiltz.com
      handle @jellyfin {
        reverse_proxy 10.10.60.198:8096
      }

      @forgejo host forgejo.public.abeehiltz.com
      handle @forgejo {
        reverse_proxy 10.10.60.187:3000
      }

      @dashboard host dashboard.public.abeehiltz.com
      handle @dashboard {
        reverse_proxy 10.10.60.180:8080
      }

      handle {
        abort
      }
    '';
  };

  # Start Caddy after the tailnet is up (not strictly required since it binds on all interfaces)
  systemd.services.caddy = {
    after = [ "tailscaled.service" ];
    wants = [ "tailscaled.service" ];
  };

  # --- Firewall: only reachable over the tailnet ---
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ ]; # nothing open on the DMZ interface
    interfaces."tailscale0".allowedTCPPorts = [ 443 ];
    # Tailscale direct connections; optional but improves peer-to-peer vs DERP relay
    allowedUDPPorts = [ config.services.tailscale.port ];
  };

}
