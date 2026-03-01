{ pkgs, username, ... }:
{
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "${username}" ];
  };

  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        vivaldi-bin
        zen
        zen-beta
        .zen
        .zen-wrapped
        .zen-beta
        .zen-wrapped
      ''; # or just "zen" if you use unwrapped package
      mode = "0755";
    };
  };  
  
}
