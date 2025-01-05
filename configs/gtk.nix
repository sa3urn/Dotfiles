{pkgs, ... }:
let
  user-name = (import /home/sa3urn/Dotfiles/variables/system.nix).user-name;
in
{
  home-manager.users.${user-name} = { pkgs, ... }: {
   gtk = {
      enable = true;
      cursorTheme.size = 22;
      cursorTheme.name = "Bibata-Modern-Ice";
      cursorTheme.package = pkgs.bibata-cursors;
    };
  };
}
