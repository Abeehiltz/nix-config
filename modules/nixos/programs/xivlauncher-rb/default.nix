{ pkgs, inputs, ... }:
{
  imports = [ inputs.nixos-xivlauncher-rb.nixosModules.default ];

  environment.systemPackages = [
    xivlauncher-rb
  ];
}
