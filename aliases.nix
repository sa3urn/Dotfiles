{ config, pkgs, ... }:

{
  programs.bash.shellAliases.sshlog =

  ''
  ssh-keygen -t rsa -b 4096 -P "" -f /home/q3e4ir/.ssh/id_rsa
  cat ~/.ssh/id_rsa.pub; echo 'https://github.com/settings/ssh/new'
  read -p 'apply ssh-key' apply
  cd ~/dotfiles
  git init
  git remote rm origin
  git remote add origin git@github.com:q3e4ir/dotfiles.git
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
  sudo cp -r /home/q3e4ir/dotfiles/* /etc/nixos/
  sudo nixos-rebuild switch
  '';

  programs.bash.shellAliases.c =

  ''
  clear
  '';
}
