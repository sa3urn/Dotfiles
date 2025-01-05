{pkgs, ... }:
let
  var = (import /home/sa3urn/Dotfiles/variables/.).var;
in
{
  home-manager.users.${var.system.user-name} = { pkgs, ... }: {
   gtk = {
      enable = true;
      cursorTheme.size = 22;
      cursorTheme.name = "Bibata-Modern-Ice";
      cursorTheme.package = pkgs.bibata-cursors;
    };
  };
}
