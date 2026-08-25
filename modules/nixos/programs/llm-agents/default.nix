{pkgs, inputs, ...}:
{
  nixpkgs.overlays = [ inputs.llm-agents.overlays.shared-nixpkgs ];
  environment.systemPackages = [
    pkgs.llm-agents.claude-desktop
    pkgs.mcp-proxy
  ];
}
