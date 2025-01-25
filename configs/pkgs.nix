{pkgs, inputs, config, ...}:
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
    qbittorrent
    hyprshot
    prismlauncher
    wpsoffice
    hyprpaper
    kdenlive
    obsidian
    appimage-run
    deskreen
    xdg-desktop-portal-hyprland
    libsForQt5.qt5.qtwebengine
    inputs.ayugram-desktop.packages.${pkgs.system}.ayugram-desktop
  ];

  xdg.portal.wlr.enable = true;
  programs.obs-studio.enable = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''`
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  programs.obs-studio.plugins = with pkgs.obs-studio-plugins; [
      obs-backgroundremoval
      obs-webkitgtk
      wlrobs
      obs-pipewire-audio-capture
      obs-3d-effect
      obs-move-transition
      obs-composite-blur
      looking-glass-obs
      input-overlay
      droidcam-obs
      advanced-scene-switcher
    ];

  fonts.packages = with pkgs; [(nerdfonts.override {fonts = ["JetBrainsMono"];})];
}