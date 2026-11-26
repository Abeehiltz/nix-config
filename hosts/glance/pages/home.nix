{ ... }:
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
