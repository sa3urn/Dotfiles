{pkgs, ... }:
let
  user-name = (import /home/sa3urn/Dotfiles/variables/system.nix).user-name;
in
{
  home-manager.users.${user-name} = { pkgs, ... }: {
    programs.git = {
      enable = true;
      userEmail = "durychyaroslav@gmail.com";
      userName = user-name;
    };
  };
}
