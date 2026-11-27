{ jellyfin }:
{
  type = "custom-api";
  title = "Animes - Recently added";
  frameless = true;
  cache = "10m";
  options = {
    base-url = jellyfin;
    api-key = "\${JELLYFIN_API_KEY}";
    user-name = "root";
    library-name = "Animes";
    mode = "latest";
    item-count = "12";
    media-types = "Movie,Episode";
    show-thumbnail = true;
    thumbnail-aspect-ratio = "portrait";
  };
  template = builtins.readFile ./templates/jellyfin-latest.tmpl;
}
