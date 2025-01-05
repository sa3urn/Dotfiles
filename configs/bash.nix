let
   user-name = (import /home/sa3urn/Dotfiles/variables/system.nix).user-name;
in
{
  programs.bash.shellAliases = {
    sshlog = ''
    ssh-keygen -t rsa -b 4096 -P "" -f /home/sa3urn/.ssh/id_rsa
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
    sudo cp -r /home/${user-name}/Dotfiles/configuration.nix /etc/nixos/
    sudo nixos-rebuild switch
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