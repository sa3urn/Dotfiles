{pkgs, ... }:
let
  user-name = (import /home/sa3urn/Dotfiles/variables/system.nix).user-name;
  nix-version = (import /home/sa3urn/Dotfiles/variables/system.nix).nix-version;
in 
{
  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    users.${user-name} = { pkgs, ... }: {
    home.stateVersion = nix-version;
    };
  };
}