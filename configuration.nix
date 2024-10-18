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
    ./gtk.nix
    ./aliases.nix
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

  i18n.extraLocaleSettings.LC_ADDRESS        = "uk_UA.UTF-8";
  i18n.extraLocaleSettings.LC_IDENTIFICATION = "uk_UA.UTF-8";
  i18n.extraLocaleSettings.LC_MEASUREMENT    = "uk_UA.UTF-8";
  i18n.extraLocaleSettings.LC_MONETARY       = "uk_UA.UTF-8";
  i18n.extraLocaleSettings.LC_NAME           = "uk_UA.UTF-8";
  i18n.extraLocaleSettings.LC_NUMERIC        = "uk_UA.UTF-8";
  i18n.extraLocaleSettings.LC_PAPER          = "uk_UA.UTF-8";
  i18n.extraLocaleSettings.LC_TELEPHONE      = "uk_UA.UTF-8";
  i18n.extraLocaleSettings.LC_TIME           = "uk_UA.UTF-8";

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
    blueman
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

  ### USERS ###
  
  users.users.q3e4ir.isNormalUser = true;
  users.users.q3e4ir.extraGroups = ["audio" "networkmanager" "wheel" ];
  users.users.q3e4ir.name = "q3e4ir";
  users.users.q3e4ir.home = "/home/q3e4ir";

  ### HOME MANAGER ###
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.q3e4ir.home.stateVersion = "24.05";
}
