{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../terminal/k9s
    ../terminal/lazygit
  ];

  home.packages = with pkgs; [
    talosctl
    kompose
    kubectl
    kubernetes-helm
    ansible
    openvpn
    dnsutils
    openssl
    inetutils

    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.pi
    mcp-nixos
  ];
  home.file.".pi/agent/mcp.json".text = builtins.toJSON {
    mcpServers.nixos = {
      command = lib.getExe pkgs.mcp-nixos;
      description = "Search NixOS packages, options, Home Manager and nix-darwin options";
    };
  };
}
