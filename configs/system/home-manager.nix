{pkgs, ... }:
let
  var = (import /home/sa3urn/Desktop/Dotfiles/variables/.).var;
in 
{
  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    users.${var.system.user-name} = { pkgs, ... }: {
    home.stateVersion = var.system.nix-version;
    };
  };
}