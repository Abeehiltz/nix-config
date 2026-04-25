{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [ inputs.millennium.overlays.default ];

  # Steam gaming platform configuration
  programs.steam = {
    enable = true;
    package = pkgs.millennium-steam; # millenium customization
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
}
