let
   var = (import /home/sa3urn/Dotfiles/variables/.).var;
in
{
  programs.bash.shellAliases = {
    sshlog = ''
    ssh-keygen -t rsa -b 4096 -P "" -f /home/${var.system.user-name}/.ssh/id_rsa
    cat ~/.ssh/id_rsa.pub; echo 'https://github.com/settings/ssh/new'
    read -p 'apply ssh-key' apply
    cd ~/Dotfiles
    git init
    git remote rm origin
    git remote add origin git@github.com:sa3urn/Dotfiles.git
    '';

    dotcommit  = ''
    cd ~/Dotfiles
    git add .
    git commit -m 'commit'
    git push -u origin main
    '';

    nixreb = ''
    sudo cp -r /home/${var.system.user-name}/Dotfiles/configs/configuration.nix /etc/nixos/
    sudo nixos-rebuild switch --impure --flake /home/${var.system.user-name}/Dotfiles#default --cores 8
    '';

    delgar = ''
    sudo nix-collect-garbage --delete-older-than 1d
    '';

    c = ''
    clear
    '';

    hyprreb = ''hyprctl dispatch exit'';
  };
}