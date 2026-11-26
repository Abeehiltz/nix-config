{ jellyfin }:
{

  size = "full";
  type = "custom-api";
  title = "Animes and Movies - Recently added";
  cache = "10m";
  url = "${jellyfin}/Items";
  parameters = {
    limit = "12";
    recursive = "true";
    sortOrder = "Descending";
    includeItemTypes = [
      "Episode"
      "Movie"
    ];
    sortBy = "DateCreated";
  };

  headers = {
    Authorization = "MediaBrowser Token=\"\${JELLYFIN_API_KEY}\"";
  };
  template = ''
    <div class="carousel-container">
      <div class="cards-horizontal carousel-items-container">
      {{ range .JSON.Array "Items" }}
        {{ $isEp := eq (.String "Type") "Episode" }}
        <a class="card widget-content-frameless"
           style="flex: 0 0 130px; width: 130px; min-width: 0; max-width: 130px; text-decoration: none;"
           href="${jellyfin}/web/index.html#!/details?id={{ if $isEp }}{{ .String "SeriesId" }}{{ else }}{{ .String "Id" }}{{ end }}"
           target="_blank" rel="noreferrer">
          {{ if $isEp }}
          <img src="${jellyfin}/Items/{{ .String "SeriesId" }}/Images/Primary?tag={{ .String "SeriesPrimaryImageTag" }}&fillWidth=220&fillHeight=330&quality=85"
               loading="lazy" style="width: 100%; aspect-ratio: 2/3; object-fit: cover; border-radius: 6px;">
          {{ else }}
          <img src="${jellyfin}/Items/{{ .String "Id" }}/Images/Primary?fillWidth=220&fillHeight=330&quality=85"
               loading="lazy" style="width: 100%; aspect-ratio: 2/3; object-fit: cover; border-radius: 6px;">
          {{ end }}
          <div class="color-highlight text-truncate" style="margin-top: 6px;">
            {{ if $isEp }}{{ .String "SeriesName" }}{{ else }}{{ .String "Name" }}{{ end }}
          </div>
          <div class="size-h6 color-subdue text-truncate">
            {{ if $isEp }}S{{ printf "%02d" (.Int "ParentIndexNumber") }}E{{ printf "%02d" (.Int "IndexNumber") }} · {{ .String "Name" }}{{ else }}{{ .Int "ProductionYear" }}{{ end }}
          </div>
        </a>
      {{ end }}
      </div>
    </div>
  '';
}
