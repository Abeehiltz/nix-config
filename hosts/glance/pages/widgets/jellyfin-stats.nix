{ jellyfin }:
let
  auth = "MediaBrowser Token=\"\${JELLYFIN_API_KEY}\"";
in
{
  type = "custom-api";
  title = "Jellyfin Stats";
  cache = "30s";
  url = "${jellyfin}/Sessions";
  headers = {
    Authorization = auth;
    Accept = "application/json";
  };
  subrequests.counts = {
    url = "${jellyfin}/Items/Counts";
    headers = {
      Authorization = auth;
      Accept = "application/json";
    };
  };
  template = builtins.readFile ./templates/jellyfin-stats.tmpl;
}
