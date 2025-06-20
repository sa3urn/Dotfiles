{pkgs, inputs, config, ...}:
{
  environment.systemPackages = with pkgs; [
    git
    firefox
    wine
    wine64
    prismlauncher
    obsidian
    discord
    telegram-desktop
    qbittorrent
    playerctl
    networkmanagerapplet
    swaybg
    dmenu
    kitty
    blueman
    pavucontrol
    obs-studio
    vlc
    audacity
    gnome-multi-writer
  ];
  services.flatpak.enable = true;
  fonts.packages = with pkgs; [monocraft];
}