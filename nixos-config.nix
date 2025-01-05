{inputs, outputs, config, pkgs, ... }:
let
  colors = (import /home/sa3urn/Dotfiles/variables/style.nix).colors;
  font = (import /home/sa3urn/Dotfiles/variables/style.nix).font;
  user-name = (import /home/sa3urn/Dotfiles/variables/system.nix).user-name;
  nix-version = (import /home/sa3urn/Dotfiles/variables/system.nix).nix-version;
in 
{
  ### IMPORTS ###
  imports = [
    <home-manager/nixos>
    /home/sa3urn/Dotfiles/configs/kitty.nix
    /home/sa3urn/Dotfiles/configs/hyprland.nix
    /home/sa3urn/Dotfiles/configs/waybar.nix
    /home/sa3urn/Dotfiles/configs/bash.nix
    /home/sa3urn/Dotfiles/configs/tlp.nix
    /home/sa3urn/Dotfiles/configs/pipewire.nix
    /home/sa3urn/Dotfiles/configs/bluetooth.nix
    /home/sa3urn/Dotfiles/configs/steam.nix
    /home/sa3urn/Dotfiles/configs/vscode.nix
    /home/sa3urn/Dotfiles/configs/autologin.nix
    /home/sa3urn/Dotfiles/configs/git.nix
    /home/sa3urn/Dotfiles/configs/polkit.nix
    /home/sa3urn/Dotfiles/pkgs.nix
  ];
  
  ### BOOT LOADER ###
  boot.loader = {
    systemd-boot.enable      = true;
    efi.canTouchEfiVariables = true;
  };

  ### USER ###
  users.users.${user-name} = {
    isNormalUser = true;
    extraGroups  = ["audio" "networkmanager" "wheel" "input"];
  };


  ### NIX ###
  system.stateVersion                = nix-version;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree         = true;
  documentation.nixos.enable         = false;

  ### NIX HOME MANAGER ###
  home-manager = {
    backupFileExtension                  = "backup";
    useGlobalPkgs                        = true;
  };

  ### LOCALES ###
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone      = "Europe/Kyiv";

  ### ENVIRONMENT VARIABLES ###
  environment.variables = {
    SUDO_EDITOR    = "codium";
    SYSTEMD_EDITOR = "codium";
    EDITOR         = "codium";
    VISUAL         = "codium";
  };

  ### NETWORK ###
  networking = {
    hostName = user-name; 
    wireless.iwd.enable = true;
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
  };

  ### HOME MANAGER OPTIONS ###
  home-manager.users.${user-name} = { pkgs, ... }: {
    home.stateVersion = nix-version;
    ### GTK ###
    gtk = {
      enable = true;
      cursorTheme.size = 22;
      cursorTheme.name = "Bibata-Modern-Ice";
      cursorTheme.package = pkgs.bibata-cursors;
    };
  };
}
