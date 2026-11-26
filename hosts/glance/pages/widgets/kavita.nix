{ kavita }:
{
  type = "custom-api";
  title = "Manga - Recently added";
  frameless = true;
  cache = "10m";
  url = "${kavita}/api/Series/recently-added-v2";
  method = "POST";
  parameters = {
    pageNumber = "1";
    pageSize = "20";
  };
  headers = {
    x-api-key = "\${KAVITA_API_KEY}";
    Accept = "application/json";
  };
  body = { }; # sends {}

  options = {
    base-url = kavita;
    api-key = "\${KAVITA_API_KEY}";
  };

  template = ''
    {{ $baseURL := .Options.StringOr "base-url" "" }}
    {{ $key := .Options.StringOr "api-key" "" }}

    <div class="carousel-container show-right-cutoff">
      <div class="cards-horizontal carousel-items-container">
        {{ range .JSON.Array "" }}
          {{ $id := .String "id" }}
          <a class="card widget-content-frameless"
             style="flex: 0 0 130px; width: 130px; min-width: 0; max-width: 130px; text-decoration: none;"
             href="{{ concat $baseURL "/library/" (.String "libraryId") "/series/" $id | safeURL }}"
             target="_blank" rel="noreferrer">
            <img src="{{ concat $baseURL "/api/image/series-cover?seriesId=" $id "&apiKey=" $key | safeURL }}"
                 loading="lazy"
                 style="width: 100%; aspect-ratio: 2/3; object-fit: cover; border-radius: 6px;">
            <div class="color-highlight text-truncate" style="margin-top: 6px;">{{ .String "name" }}</div>
          </a>
        {{ end }}
      </div>
    </div>
  '';

}
