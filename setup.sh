#!/usr/bin/env bash
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
sudo nix-channel --update
sudo cp -r /home/sa3urn/dotfiles/* /etc/nixos/
sudo nixos-rebuild switch --upgrade
