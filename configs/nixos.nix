{pkgs, ... }:
let
  nix-version = (import /home/sa3urn/Dotfiles/variables/system.nix).nix-version;
in 
{
  system.stateVersion                = nix-version;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree         = true;
  documentation.nixos.enable         = false;
}