{ config, pkgs, ... }:
### VARIABLES ###

### MAIN CONFIG ###
{
  ###  IMPORTS ###
  imports = [
    <home-manager/nixos>
    ./hardware-configuration.nix 
    ./vscode.nix
    ./kitty.nix
    ./waybar.nix
  ];

  ### BOOT SETTINGS ###
  boot.loader.systemd-boot.enable      = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.getty.autologinUser = "q3e4ir";
  services.displayManager.enable = true;

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
  networking.hostName = "nixos"; 
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
    google-chrome
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

    ### HYPRLAND ###
    wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.settings."###" = ''
    ###
    monitor=,preferred,auto,1
    env = XCURSOR_SIZE,24
    input {
      kb_layout = us,ru
      kb_variant =
      kb_model =
      kb_options = grp:win_space_toggle
      kb_rules = 

      follow_mouse = 1

      touchpad {
          natural_scroll = yes
      }

      sensitivity = -0.1
    }

    general {
      gaps_in = 5
      gaps_out = 5
      border_size = 2
      col.active_border = rgb(b4befe)
      col.inactive_border = rgb(1e1e2e)
      layout = dwindle
      allow_tearing = false
    }

    decoration {
      rounding = 5

      blur {
        enabled = true
        size = 3
        passes = 1
      }

      drop_shadow = yes
      shadow_range = 4
      shadow_render_power = 3
      col.shadow = rgba(1a1a1aee)
      active_opacity = 0.97
      inactive_opacity = 0.95
    }

    animations {
      enabled = yes

      bezier = myBezier, 0.05, 0.9, 0.1, 1.05

      animation = windows, 1, 7, myBezier
      animation = windowsOut, 1, 7, default, popin 80%
      animation = border, 1, 10, default
      animation = borderangle, 1, 8, default
      animation = fade, 1, 7, default
      animation = workspaces, 1, 6, default
    }

    dwindle {
      pseudotile = yes
      preserve_split = yes 
    }


    gestures {
      workspace_swipe = off
    }

    misc {
      force_default_wallpaper = 0 
      disable_splash_rendering = true
      disable_hyprland_logo = true
    }

    $mainMod = SUPER
    $editor = codium

    exec-once = waybar
    exec-once = hyprpaper

    windowrulev2 = stayfocused,       class:(Lxpolkit)

    bind = $mainMod, RETURN,                  exec, kitty --hold

    bind = $mainMod, A,                       exec, wofi --show drun

    bind = $mainMod, W,                       killactive, 
    bind = $mainMod, M,                       exit, 
    bind = $mainMod, F,                       togglefloating, 
    bind = $mainMod, J,                       togglesplit, 

    bind = $mainMod, 1,                       workspace, 1
    bind = $mainMod, 2,                       workspace, 2
    bind = $mainMod, 3,                       workspace, 3
    bind = $mainMod, 4,                       workspace, 4
    bind = $mainMod, 5,                       workspace, 5
    bind = $mainMod, 6,                       workspace, 6
    bind = $mainMod, 7,                       workspace, 7
    bind = $mainMod, 8,                       workspace, 8
    bind = $mainMod, 9,                       workspace, 9
    bind = $mainMod, 0,                       workspace, 10

    bind = $mainMod SHIFT, 1,                 movetoworkspace, 1
    bind = $mainMod SHIFT, 2,                 movetoworkspace, 2
    bind = $mainMod SHIFT, 3,                 movetoworkspace, 3
    bind = $mainMod SHIFT, 4,                 movetoworkspace, 4
    bind = $mainMod SHIFT, 5,                 movetoworkspace, 5
    bind = $mainMod SHIFT, 6,                 movetoworkspace, 6
    bind = $mainMod SHIFT, 7,                 movetoworkspace, 7
    bind = $mainMod SHIFT, 8,                 movetoworkspace, 8
    bind = $mainMod SHIFT, 9,                 movetoworkspace, 9
    bind = $mainMod SHIFT, 0,                 movetoworkspace, 10

    bind = $mainMod, mouse_down, workspace,   e+1
    bind = $mainMod, mouse_up, workspace,     e-1

    bindm = $mainMod, mouse:272,              movewindow
    bindm = $mainMod, mouse:273,              resizewindow
    '';

    ### WOFI ###
    programs.wofi.enable = true;
    programs.wofi.settings."" = ''
    show=drun
    width=50%
    height=40%
    location=center
    always_parse_args=true
    allow_markup=false
    show_all=true
    term=kitty
    hide_scroll=false
    print_command=true
    insensitive=true
    prompt=drun
    columns=3
    allow_images=false
    '';
    programs.wofi.style = ''
    @define-color	rosewater  #f5e0dc;
    @define-color	rosewater-rgb  rgb(245, 224, 220);
    @define-color	flamingo  #f2cdcd;
    @define-color	flamingo-rgb  rgb(242, 205, 205);
    @define-color	pink  #f5c2e7;
    @define-color	pink-rgb  rgb(245, 194, 231);
    @define-color	mauve  #cba6f7;
    @define-color	mauve-rgb  rgb(203, 166, 247);
    @define-color	red  #f38ba8;
    @define-color	red-rgb  rgb(243, 139, 168);
    @define-color	maroon  #eba0ac;
    @define-color	maroon-rgb  rgb(235, 160, 172);
    @define-color	peach  #fab387;
    @define-color	peach-rgb  rgb(250, 179, 135);
    @define-color	yellow  #f9e2af;
    @define-color	yellow-rgb  rgb(249, 226, 175);
    @define-color	green  #a6e3a1;
    @define-color	green-rgb  rgb(166, 227, 161);
    @define-color	teal  #94e2d5;
    @define-color	teal-rgb  rgb(148, 226, 213);
    @define-color	sky  #89dceb;
    @define-color	sky-rgb  rgb(137, 220, 235);
    @define-color	sapphire  #74c7ec;
    @define-color	sapphire-rgb  rgb(116, 199, 236);
    @define-color	blue  #89b4fa;
    @define-color	blue-rgb  rgb(137, 180, 250);
    @define-color	lavender  #b4befe;
    @define-color	lavender-rgb  rgb(180, 190, 254);
    @define-color	text  #cdd6f4;
    @define-color	text-rgb  rgb(205, 214, 244);
    @define-color	subtext1  #bac2de;
    @define-color	subtext1-rgb  rgb(186, 194, 222);
    @define-color	subtext0  #a6adc8;
    @define-color	subtext0-rgb  rgb(166, 173, 200);
    @define-color	overlay2  #9399b2;
    @define-color	overlay2-rgb  rgb(147, 153, 178);
    @define-color	overlay1  #7f849c;
    @define-color	overlay1-rgb  rgb(127, 132, 156);
    @define-color	overlay0  #6c7086;
    @define-color	overlay0-rgb  rgb(108, 112, 134);
    @define-color	surface2  #585b70;
    @define-color	surface2-rgb  rgb(88, 91, 112);
    @define-color	surface1  #45475a;
    @define-color	surface1-rgb  rgb(69, 71, 90);
    @define-color	surface0  #313244;
    @define-color	surface0-rgb  rgb(49, 50, 68);
    @define-color	base  #1e1e2e;
    @define-color	base-rgb  rgb(30, 30, 46);
    @define-color	mantle  #181825;
    @define-color	mantle-rgb  rgb(24, 24, 37);
    @define-color	crust  #11111b;
    @define-color	crust-rgb  rgb(17, 17, 27);

    * {
      font-family: 'Inconsolata Nerd Font', monospace;
      font-size: 14px;
    }

    /* Window */
    window {
      margin: 0px;
      padding: 10px;
      border: 0.16em solid @lavender;
      border-radius: 0.1em;
      background-color: @base;
      animation: slideIn 0.5s ease-in-out both;
    }

    /* Slide In */
    @keyframes slideIn {
      0% {
        opacity: 0;
      }

      100% {
        opacity: 1;
      }
    }

    /* Inner Box */
    #inner-box {
      margin: 5px;
      padding: 10px;
      border: none;
      background-color: @base;
      animation: fadeIn 0.5s ease-in-out both;
    }

    /* Fade In */
    @keyframes fadeIn {
      0% {
        opacity: 0;
      }

      100% {
        opacity: 1;
      }
    }

    /* Outer Box */
    #outer-box {
      margin: 5px;
      padding: 10px;
      border: none;
      background-color: @base;
    }

    /* Scroll */
    #scroll {
      margin: 0px;
      padding: 10px;
      border: none;
      background-color: @base;
    }

    /* Input */
    #input {
      margin: 5px 20px;
      padding: 10px;
      border: none;
      border-radius: 0.1em;
      color: @text;
      background-color: @base;
      animation: fadeIn 0.5s ease-in-out both;
    }

    #input image {
        border: none;
        color: @red;
    }

    /* Text */
    #text {
      margin: 5px;
      border: none;
      color: @text;
      animation: fadeIn 0.5s ease-in-out both;
    }

    #entry {
      background-color: @base;
    }

    #entry arrow {
      border: none;
      color: @lavender;
    }

    /* Selected Entry */
    #entry:selected {
      border: 0.11em solid @lavender;
    }

    #entry:selected #text {
      color: @mauve;
    }
    '';

    ### HYPRPAPER ###
    services.hyprpaper.enable = true;
    services.hyprpaper.settings."###" = ''
    ###
    preload = /home/q3e4ir/wallpaper.png
    wallpaper = eDP-1, /home/q3e4ir/wallpaper.png
    '';
    };

  }
