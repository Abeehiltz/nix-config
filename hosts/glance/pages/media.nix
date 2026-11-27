{ jellyfin, kavita }:
let
  # Percent-encode the characters that matter for Nyaa queries.
  encodeQuery =
    builtins.replaceStrings
      [
        " "
        "\""
        "|"
        "("
        ")"
        "-"
        "'"
      ]
      [
        "+"
        "%22"
        "%7C"
        "%28"
        "%29"
        "%2D"
        "%27"
      ];

  mkNyaa =
    {
      title,
      query ? null,
      # Alternative: list of series, joined into one OR query
      series ? [ ],
      cat ? "3_1",
      filter ? "0",
      limit ? 5,
    }:
    let
      q = if query != null then query else builtins.concatStringsSep "|" (map (s: "\"${s}\"") series);
    in
    {
      inherit title limit;
      url = "https://nyaa.si/?page=rss&c=${cat}&f=${filter}&q=" + encodeQuery q;
    };
in
{
  name = "Media tracking";
  columns = [
    {
      size = "small";
      widgets = [
        (import ./widgets/jellyfin-stats.nix { inherit jellyfin; })
        {
          type = "rss";
          title = "Manga releases on Nyaa";
          style = "vertical-list";
          limit = 20;
          collapse-after = 10;
          preserve-order = true;
          cache = "30m";
          feeds = [
            (mkNyaa {
              title = "Tracked series";
              limit = 20;
              series = [
                "Yuri is my job"
                "The Moon on a Rainy Night"
                "The Fed-Up Office Lady Wants to Serve the Villainess"
                "Anemone wa Netsu o Obiru"
                "Watashi no Oshi wa Akuyaku Reijou"
                "I Want to Love You Till Your Dying Day"
              ];
            })
          ];
        }
      ];
    }
    {
      size = "full";
      widgets = [
        (import ./widgets/jellyfin.nix { inherit jellyfin; })
        (import ./widgets/kavita.nix { inherit kavita; })
      ];
    }
  ];
}
