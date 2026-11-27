{ kavita }:
{
  type = "custom-api";
  title = "Manga - Recently added";
  frameless = true;
  cache = "10m";
  options = {
    base-url = kavita;
    api-key = "\${KAVITA_API_KEY}";
    mode = "recently-added";
    show-thumbnail = true;
    thumbnail-aspect-ratio = "portrait";
  };
  template = builtins.readFile ./templates/kavita-latest.tmpl;
}
