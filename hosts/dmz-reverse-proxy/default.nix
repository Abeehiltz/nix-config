{
  modulesPath,
  pkgs,
  lib,
  nixosModules,
  hostname,
  config,
  ...
}:
let
  # Backends behind the Envoy gateway (HTTPS, SNI must match)
  envoyBackend = domain: name: ''
    @${name} host ${name}.${domain}
    handle @${name} {
      reverse_proxy https://10.10.60.220 {
        header_up Host ${name}.${domain}
        transport http {
          tls_server_name ${name}.${domain}
        }
      }
    }
  '';

  mkSites = domain: ''
    tls {
      dns cloudflare {env.CF_API_TOKEN}
      resolvers 1.1.1.1
    }

    @jellyfin host jellyfin.${domain}
    handle @jellyfin {
      reverse_proxy 10.10.60.198:8096
    }

    @forgejo host forgejo.${domain}
    handle @forgejo {
      reverse_proxy 10.10.60.187:3000
    }

    @dashboard host dashboard.${domain}
    handle @dashboard {
      reverse_proxy 10.10.60.180:8080
    }

    ${lib.concatMapStrings (envoyBackend domain) [
      "music"
      "mangas"
      "books"
    ]}

    handle {
      abort
    }
  '';
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
  system.stateVersion = "26.11";

  # SECRET MANAGEMENT
  sops = {
    defaultSopsFile = ../../secrets/dmz-reverse-proxy.yaml;

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
      "--advertise-tags=tag:friend-gw" # must match the tag on the auth key
      "--accept-dns=false" # stop tailscaled fighting over resolv.conf in the container
    ];
  };

  # --- Caddy ---
  services.caddy = {
    enable = true;
    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@v0.2.1" ];
      hash = "sha256-88e3zkffSC9RgOA1OtNKRakrbOxoNA5Kl1u9tFeozI0=";
    };
    environmentFile = config.sops.secrets.caddy-env.path;

    virtualHosts."*.abeehiltz.com".extraConfig = mkSites "abeehiltz.com";
    # transition only: delete once everyone uses the plain names
    virtualHosts."*.public.abeehiltz.com".extraConfig = mkSites "public.abeehiltz.com";

    virtualHosts."id.abeehiltz.com".extraConfig = ''
      tls {
        dns cloudflare {env.CF_API_TOKEN}
        resolvers 1.1.1.1
      }
      reverse_proxy https://10.10.60.220 {
        header_up Host id.abeehiltz.com
        transport http {
          tls_server_name id.abeehiltz.com
        }
      }
    '';

    virtualHosts."auth.abeehiltz.com".extraConfig = ''
      tls {
        dns cloudflare {env.CF_API_TOKEN}
        resolvers 1.1.1.1
      }
      reverse_proxy https://10.10.60.220 {
        header_up Host auth.abeehiltz.com
        transport http {
          tls_server_name auth.abeehiltz.com
        }
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
