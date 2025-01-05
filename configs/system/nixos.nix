{pkgs, ... }:
let
  var = (import /home/sa3urn/Dotfiles/variables/.).var;
in 
{
  system.stateVersion                = var.system.nix-version;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree         = true;
  documentation.nixos.enable         = false;
}