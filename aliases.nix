{ config, pkgs, ... }:

{
  programs.bash.shellAliases.sshlog =

  ''
  ssh-keygen -t rsa -b 4096 -P "" -f /home/sa3urn/.ssh/id_rsa
  cat ~/.ssh/id_rsa.pub; echo 'https://github.com/settings/ssh/new'
  read -p 'apply ssh-key' apply
  cd ~/dotfiles
  git init
  git remote rm origin
  git remote add origin git@github.com:sa3urn/dotfiles.git
  '';

  programs.bash.shellAliases.dotcommit  =

  ''
  cd ~/dotfiles
  git add .
  git commit -m 'commit'
  git push -u origin main
  '';

  programs.bash.shellAliases.nixreb =

  ''
  sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
  sudo nix-channel --update
  sudo cp -r /home/sa3urn/dotfiles/* /etc/nixos/
  sudo nixos-rebuild switch --upgrade
  sudo nix-collect-garbage --delete-older-than 1d
  '';

  programs.bash.shellAliases.c =

  ''
  clear
  '';
}
