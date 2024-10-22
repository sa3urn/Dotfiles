{ config, pkgs, ... }:

### MAIN CONFIG ###
{
  ###  IMPORTS ###
  imports = [
    <home-manager/nixos>
    ./hardware-configuration.nix 
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

  environment.variables.SUDO_EDITOR    = "code";
  environment.variables.SYSTEMD_EDITOR = "code";
  environment.variables.EDITOR         = "code";
  environment.variables.VISUAL         = "code";

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
  security.polkit.extraConfig = ''
  polkit.addRule(function(action, subject) {
    if (subject.isInGroup("wheel"))
      return polkit.Result.YES;
    });
  '';

  ### TLP ###
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;
      START_CHARGE_THRESH_BAT0 = 50;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };
  
  ### PACkAGES ###
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.pulseaudio = true;
  documentation.nixos.enable = false;

  programs.steam.enable = true;
  programs.steam.remotePlay.openFirewall = true; 
  programs.steam.dedicatedServer.openFirewall = true;
  programs.steam.localNetworkGameTransfers.openFirewall = true;
  programs.steam.gamescopeSession.enable = true;

  environment.systemPackages = with pkgs; [
    bashmount
    ntfs3g
    git
    polkit
    polkit_gnome
    lxsession
    unzip
    pulseaudio
    blueman
    firefox
    vscode
    spotify
    telegram-desktop
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
  programs.hyprland.enable = true;
  services.blueman.enable = true;

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
