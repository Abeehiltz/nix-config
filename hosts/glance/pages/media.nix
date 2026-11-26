{ jellyfin, kavita }:
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
      size = "full";
      widgets = [
        (import ./widgets/jellyfin.nix { inherit jellyfin; })
        (import ./widgets/kavita.nix { inherit kavita; })
      ];
    }
  ];
}
