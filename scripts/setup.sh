#!/usr/bin/env bash
sudo nix-channel --add https://channels.nixos.org/nixos-24.11 nixos
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager
sudo nix-channel --update
sudo cp -r /home/sa3urn/Dotfiles/configuration.nix /etc/nixos/
sudo nixos-rebuild switch --upgrade
