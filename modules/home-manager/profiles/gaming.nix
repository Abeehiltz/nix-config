{ pkgs, ... }: {
  home.packages = with pkgs; [
    lutris
    sgdboop
    vintagestory
  ];
}
