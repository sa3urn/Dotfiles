{inputs, config, pkgs, ... }:
{
  imports = [
    /etc/nixos/hardware-configuration.nix 
    /home/sa3urn/dotfiles/nixos-config.nix
  ];
}
