{
  modulesPath,
  nixosModules,
  hostname,
  ...
}:
let
  jellyfin = "https://jellyfin.abeehiltz.com";
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

  # Glance config
  services.glance = {
    environmentFile = "/var/lib/secrets/glance.env";
    enable = true;
    openFirewall = true;
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

      pages = [
        # ---------------------------------------------------------- HOME
        {
          name = "Home";
          columns = [
            {
              size = "small";
              widgets = [
                {
                  type = "clock";
                  hour-format = "24h";
                  timezones = [
                    {
                      timezone = "Europe/Luxembourg";
                      label = "Luxembourg";
                    }
                  ];
                }
                {
                  type = "weather";
                  location = "Luxembourg, Luxembourg";
                  units = "metric";
                  hour-format = "24h";
                }
              ];
            }

            {
              size = "full";
              widgets = [
                # Up/down status + quick links in one widget
                {
                  type = "monitor";
                  cache = "1m";
                  title = "Services";
                  sites = [
                    {
                      title = "Jellyfin";
                      url = "https://jellyfin.abeehiltz.com";
                      icon = "di:jellyfin";
                    }
                    {
                      title = "Mangas";
                      url = "https://mangas.abeehiltz.com";
                      icon = "di:kavita";
                    }
                    {
                      title = "Books";
                      url = "https://books.abeehiltz.com";
                      icon = "sh:grimmory";
                    }
                    {
                      title = "Music";
                      url = "https://music.abeehiltz.com";
                      icon = "di:navidrome";
                    }
                  ];
                }

                # Favourite websites (no status check)
                {
                  type = "bookmarks";
                  groups = [
                    {
                      title = "Nix Bookmarks";
                      links = [
                        {
                          title = "NixOS Search";
                          url = "https://search.nixos.org";
                        }
                        {
                          title = "My NixOS Search";
                          url = "https://mynixos.com/";
                        }
                      ];
                    }
                    {
                      title = "Media";
                      links = [
                        {
                          title = "Nyaa";
                          url = "https://nyaa.si";
                        }
                      ];
                    }
                  ];
                }
              ];
            }
          ];
        }

        # --------------------------------------------------------- MANGA
        {
          name = "Media tracking";
          columns = [
            {
              size = "small";
              widgets = [
                {
                  type = "rss";
                  title = "Manga releases";
                  style = "detailed-list";
                  limit = 40;
                  collapse-after = 15;
                  cache = "30m";
                  feeds = [
                  ];
                }
              ];
            }
            {
              type = "custom-api";
              title = "Recently added";
              cache = "10m";
              url = "${jellyfin}/Items?SortBy=DateCreated&SortOrder=Descending&Recursive=true&IncludeItemTypes=Movie,Episode&Limit=12";
              headers = {
                # the backslash stops Nix from interpolating; Glance expands it from the env file
                X-Emby-Token = "\${JELLYFIN_API_KEY}";
              };
              template = ''
                <div class="carousel-container">
                  <div class="cards-horizontal carousel-items-container">
                  {{ range .JSON.Array "Items" }}
                    <a class="card widget-content-frameless" style="flex: 0 0 110px; text-decoration: none;"
                       href="${jellyfin}/web/index.html#!/details?id={{ .String "Id" }}" target="_blank" rel="noreferrer">
                      <img src="${jellyfin}/Items/{{ .String "Id" }}/Images/Primary?maxHeight=300&quality=80"
                           loading="lazy" style="width: 100%; aspect-ratio: 2/3; object-fit: cover; border-radius: 6px;">
                      <div class="color-highlight text-truncate" style="margin-top: 6px;">
                        {{ if .String "SeriesName" }}{{ .String "SeriesName" }}{{ else }}{{ .String "Name" }}{{ end }}
                      </div>
                      <div class="size-h6 color-subdue text-truncate">
                        {{ if .String "SeriesName" }}{{ .String "Name" }}{{ else }}{{ .Int "ProductionYear" }}{{ end }}
                      </div>
                    </a>
                  {{ end }}
                  </div>
                </div>
              '';
            }
          ];
        }
      ];
    };
  };
}
