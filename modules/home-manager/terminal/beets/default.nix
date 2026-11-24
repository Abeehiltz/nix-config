{ lib, pkgs, ...}:
{
  programs.beets = {
    enable = true;
  
    settings = {
      directory = "/mnt/media/Music";
      library = "/home/abee/musiclibrary.db";
  
      plugins = [ "fetchart" "missing" "musicbrainz" "mbsync" "scrub" "duplicates" ];
  
      musicbrainz = {
        searchlimit = 10;
        extra_tags = [ "year" "catalognum" "country" "media" "label" ];
      };
  
      import = {
        write = true;
        move = true;
        languages = [ "en" "jp" ];
      };
  
      artist_credit = true;
      va_name = "Various Artists";
  
      fetchart = {
        auto = true;
        maxwidth = 1000;
        quality = 75;
        sources = [ "filesystem" "coverart" "itunes" "amazon" "albumart" ];
      };
    };
  };
}
