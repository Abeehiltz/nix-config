{ pkgs, ... }: {
  imports = [
    ../terminal/mpv
    ../terminal/beets
    ../terminal/gallery-dl
    ../terminal/feh
  ];

  home.packages = with pkgs; [
    ffmpeg-full
    imagemagick

    feishin # Music player
    cine # Video player
    jellyfin-desktop
    nicotine-plus
    qbittorrent

    # Creative
    gimp
    krita
    pkgsRocm.blender
  ];
}
