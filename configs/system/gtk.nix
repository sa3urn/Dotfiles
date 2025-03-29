{pkgs, ... }:
let
  var = (import /home/sa3urn/Desktop/Dotfiles/variables/.).var;
in
{
  home-manager.users.${var.system.user-name} = { pkgs, ... }: {
    #gtk.enable = true;
  };
}