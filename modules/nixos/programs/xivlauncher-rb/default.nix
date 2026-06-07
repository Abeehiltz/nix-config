{ config, lib, pkgs, inputs, ... }:
{
  environment.systemPackages = [
    pkgs.umu-launcher
    inputs.nixos-xivlauncher-rb.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
