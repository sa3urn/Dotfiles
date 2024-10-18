{ config, pkgs, ... }:

### MAIN CONFIG ###
{
  ###  IMPORTS ###
  imports = [
    <home-manager/nixos>
    ./hardware-configuration.nix 
    ./vscode.nix
    ./kitty.nix
    ./waybar.nix
    ./hyprland.nix
    ./wofi.nix
  ];

  ### BOOT SETTINGS ###
  boot.loader.systemd-boot.enable      = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.getty.autologinUser = "q3e4ir";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  ### LOCALES ###
  system.stateVersion                        = "24.05";
  i18n.defaultLocale                         = "en_US.UTF-8";
  time.timeZone                              = "Europe/Kyiv";

  i18n.extraLocaleSettings.LC_ADDRESS        = "en_US.UTF-8";
  i18n.extraLocaleSettings.LC_IDENTIFICATION = "en_US.UTF-8";
  i18n.extraLocaleSettings.LC_MEASUREMENT    = "en_US.UTF-8";
  i18n.extraLocaleSettings.LC_MONETARY       = "en_US.UTF-8";
  i18n.extraLocaleSettings.LC_NAME           = "en_US.UTF-8";
  i18n.extraLocaleSettings.LC_NUMERIC        = "en_US.UTF-8";
  i18n.extraLocaleSettings.LC_PAPER          = "en_US.UTF-8";
  i18n.extraLocaleSettings.LC_TELEPHONE      = "en_US.UTF-8";
  i18n.extraLocaleSettings.LC_TIME           = "en_US.UTF-8";

  ### NETWORK ###
  networking.hostName = "q3e4ir"; 
  networking.networkmanager.enable = true;
  ## PULSEAUDIO ##
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.extraConfig = "load-module module-combine-sink";
  ### BLUETHOOTH ###
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  ### POLKIT ###
  security.polkit.enable = true;

  ### PACkAGES ###
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.pulseaudio = true;

  environment.systemPackages = with pkgs; [
    #utils
    git
    polkit
    polkit_gnome
    lxsession
    unzip
    pulseaudio
    #applications
    firefox
    kitty
    vscode
    #system
    waybar
    hyprpaper
    wofi
    pavucontrol
    pamixer
    networkmanagerapplet
  ];

  ### FONTS ###
  fonts.packages = with pkgs; [(nerdfonts.override {fonts = ["JetBrainsMono"];})];

  ### PROGRAMS,SERVICES ###
  programs.hyprland.enable   = true;
  programs.thunar.enable     = true;
  services.gvfs.enable       = true;
  services.tumbler.enable    = true; 
  services.blueman.enable    = true;

  ### ENVIRONMENT VARIABLES ###
  environment.variables.SUDO_EDITOR    = "code";
  environment.variables.SYSTEMD_EDITOR = "code";
  environment.variables.EDITOR         = "code";
  environment.variables.VISUAL         = "code";

  ### ALIASES ###
  programs.bash.shellAliases.sshlog     = ''
  ssh-keygen -t rsa -b 4096 -P "" -f /home/q3e4ir/.ssh/id_rsa
  cat ~/.ssh/id_rsa.pub; echo 'https://github.com/settings/ssh/new'
  read -p 'apply ssh-key' apply
  cd ~/dotfiles
  git init
  git remote rm origin
  git remote add origin git@github.com:q3e4ir/dotfiles.git
  '';

  programs.bash.shellAliases.dotcommit  = ''
  cd ~/dotfiles
  git add .
  git commit -m 'commit'
  git push -u origin main
  '';

  programs.bash.shellAliases.nixreb     = ''
  sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
  sudo nix-channel --update
  sudo cp -r /home/q3e4ir/dotfiles/* /etc/nixos/
  sudo nixos-rebuild switch
  '';

  programs.bash.shellAliases.c          = ''
  clear
  '';

  programs.bash.shellAliases.vs-extlist = ''
  codium --list-extensions | xargs -L 1 echo codium --install-extension
  '';

  ### USERS ###
  
  users.users.q3e4ir.isNormalUser = true;
  users.users.q3e4ir.extraGroups = ["audio" "networkmanager" "wheel" ];
  users.users.q3e4ir.name = "q3e4ir";
  users.users.q3e4ir.home = "/home/q3e4ir";

  ### HOME MANAGER ###
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.q3e4ir = { pkgs, ... }: {
    home.stateVersion = "24.05";

    ### GTK ###
    gtk.enable = true;
    gtk.theme.name = "Juno";
    gtk.theme.package = pkgs.juno-theme;
    gtk.gtk3.extraConfig.Settings = ''gtk-application-prefer-dark-theme=1'';
    gtk.gtk4.extraConfig.Settings = ''gtk-application-prefer-dark-theme=1'';
    };

  }
