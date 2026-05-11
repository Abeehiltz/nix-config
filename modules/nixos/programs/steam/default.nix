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
      inputs.dw-proton.packages.${pkgs.stdenv.hostPlatform.system}.dw-proton
    ];

    extraPackages = with pkgs; [ hidapi ];
    extest.enable = true;  # fixed the cursor issue
  };
}
