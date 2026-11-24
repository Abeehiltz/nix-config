{...}:
{
  programs.gallery-dl = {
    enable = true;
    settings = {
      extractor = {
        base-directory = "~/Downloads/gallery-dl";
        sleep = [ 1.5 3.5 ];
        retries = 5;
        archive = "~/Downloads/gallery-dl/archive.sqlite3";
        metadata-path = "_path";

        mangafire = {
          directory = [ "mangas" "{manga}" "{manga} {volume:?v/ />02}{chapter:?c//>03}{chapter_minor:?//}{title:?: //}"];
          manga.lang = "en";
          postprocessors = ["comicinfo" "cbz"];
        };

        dynastyscans = {
          directory = [ "mangas" "{manga}" "{manga} c{chapter:>03}"];
          filename = "{filename}.{extension}";
          postprocessors = ["comicinfo" "cbz"];
        };
      };

      postprocessor = {
        comicinfo = {
#          name = "python";
#          event = "child-after";
#          function = "~/Downloads/gallery-dl/mangas/metadata-script.py:create_comicinfo_xml";
           name = "metadata";
           mode = "custom";
           filename = "ComicInfo.xml";
           event = "init,child";
           content-format = "<ComicInfo><Series>{manga}</Series></ComicInfo>";
        };
        cbz = {
          name = "zip";
          extension = "cbz";
          files = ["ComicInfo.xml"] ;
        };
      };
    };
  };
}
