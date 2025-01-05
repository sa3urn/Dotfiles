{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    waybar
    hyprpaper
    git
    unzip
    pulseaudio
    firefox
    vscodium
    kitty
    pulsemixer
    bibata-cursors
    impala
    bluetui
    sway-launcher-desktop 
    xdg-utils
    playerctl
    brightnessctl
    python311
    wine
    wine64
    htop
    killall
    hyprshot
    prismlauncher
    wpsoffice
    telegram-desktop
    hyprpaper
  ];

  fonts.packages = with pkgs; [(nerdfonts.override {fonts = ["JetBrainsMono"];})];
}