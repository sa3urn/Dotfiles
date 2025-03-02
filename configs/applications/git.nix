{pkgs, ... }:
let
  var = (import /home/sa3urn/Desktop/Dotfiles/variables/.).var;
in
{
  home-manager.users.${var.system.user-name} = { pkgs, ... }: {
    programs.git = {
      enable = true;
      userEmail = "durychyaroslav@gmail.com";
      userName = var.system.user-name;
    };
  };
}
