{ pkgs, ... }:
{
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
  ];
}
