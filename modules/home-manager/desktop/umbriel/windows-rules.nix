{
  programs.umbriel.settings.window_rule = [
    {
      blur = true;
      blur_optimized = true;
    }
    {
      match.app_id = "^dev.noctalia.Noctalia$";
      default_floating = true;
      default_size = [
        1020
        900
      ];
    }
  ];

  programs.umbriel.settings.layer_rule = [
    {
      match.namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$";
      blur = true;
      blur_ignore_alpha = 0.6;
      blur_optimized = false;
    }
  ];
}
