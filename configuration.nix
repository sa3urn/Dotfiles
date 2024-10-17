{ config, pkgs, ... }:
### VARIABLES ###

### MAIN CONFIG ###
{
  ###  IMPORTS ###
  imports = [<home-manager/nixos> ./hardware-configuration.nix];

  ### BOOT SETTINGS ###
  boot.loader.systemd-boot.enable      = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.getty.autologinUser = "q3e4ir";

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
    vscodium
    #system
    waybar
    hyprpaper
    wofi
    pavucontrol
    pamixer
    networkmanagerapplet
    gtk3
    gtk4
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
  environment.variables.SUDO_EDITOR    = "codium";
  environment.variables.SYSTEMD_EDITOR = "codium";
  environment.variables.EDITOR         = "codium";
  environment.variables.VISUAL         = "codium";

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

    ### KITTY ###
    programs.kitty.enable = true;
    programs.kitty.extraConfig = ''
    foreground              #cdd6f4
    background              #1e1e2e
    selection_foreground    #1e1e2e
    selection_background    #f5e0dc

    cursor                  #f5e0dc
    cursor_text_color       #1e1e2e

    url_color               #f5e0dc

    active_border_color     #b4befe
    inactive_border_color   #6c7086
    bell_border_color       #f9e2af

    wayland_titlebar_color system
    macos_titlebar_color system

    active_tab_foreground   #11111b
    active_tab_background   #cba6f7
    inactive_tab_foreground #cdd6f4
    inactive_tab_background #181825
    tab_bar_background      #11111b

    mark1_foreground #1e1e2e
    mark1_background #b4befe
    mark2_foreground #1e1e2e
    mark2_background #cba6f7
    mark3_foreground #1e1e2e
    mark3_background #74c7ec

    # black
    color0 #45475a
    color8 #585b70

    # red
    color1 #f38ba8
    color9 #f38ba8

    # green
    color2  #a6e3a1
    color10 #a6e3a1

    # yellow
    color3  #f9e2af
    color11 #f9e2af

    # blue
    color4  #89b4fa
    color12 #89b4fa

    # magenta
    color5  #f5c2e7
    color13 #f5c2e7

    # cyan
    color6  #94e2d5
    color14 #94e2d5

    # white
    color7  #bac2de
    color15 #a6adc8

    font_size 12.0
    confirm_os_window_close 0
    resize_debounce_time 0
    '';

    ### WAYBAR ###
    programs.waybar.enable = true;
    programs.waybar.settings = {
      mainBar = {
        layer = "top";
        position = "top";
        spacing = 0;
        height = 25;
        modules-left = ["clock" "hyprland/window"];
        modules-center = ["hyprland/workspaces"];
        modules-right = ["tray" "bluetooth" "network" "pulseaudio" "hyprland/language" "battery"];

        "hyprland/window" = {
          format = "{}";
          rewrite = {"" = "q3e4ir@nixos";};
          };
        "hyprland/language" = {
          format = "{long}";
          };
        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          format-icons = {
            default = "";
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            active = "󱓻";
            urgent = "󱓻";
            };
          "persistent_workspaces" = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
           };
          };
        "memory" = {
          interval = 5;
          format = "󰍛 %";
          max-length = 10;
          };
        "bluetooth" = {
          format = "󰂯";
          on-click = "blueman-manager";
          };
        "tray" = {
          spacing = 10;
          };
        "clock" = {
          format = "  {:%I:%M %p |   %a %d %b %Y}";
          tooltip-format = "{calendar}";
          };
        "network" = {
          format-wifi = "{icon}";
          format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          format-ethernet = "󰀂";
          format-disconnected = "󰖪";
          tooltip-format-wifi = "{icon} {essid}\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-ethernet = "󰀂  {ifname}\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-disconnected = "Disconnected";
          on-click = "nm-connection-editor";
          interval = 5;
          nospacing = 1;
          };
        "pulseaudio" = {
          format = "{icon}: {volume}%";
          nospacing = 1;
          format-muted = "󰝟";
          format-icons = {
            headphone = "";
            default = ["󰖀" "󰕾" ""];
            };
          on-click = "pavucontrol";
          scroll-step = 1;
          };
        "battery" = {
          format = "{icon} {capacity}%";
          format-icons = {
            charging = ["󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
            default = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            };
          format-full = "Charged ";
          interval = 5;
          states = {
            warning = 20;
            critical = 10;
            };
          tooltip = false;
          };
        };
      };

    programs.waybar.style = ''
    * {
        border: none;
        border-radius: 0;
        min-height: 0;
        font-family: JetBrainsMono Nerd Font;
        font-size: 13px;
      }
      
      window#waybar {
        background-color: #181825;
        transition-property: background-color;
        transition-duration: 0.5s;
      }
      
      window#waybar.hidden {
        opacity: 0.5;
      }
      
      #workspaces {
        background-color: transparent;
      }
      
      #workspaces button {
        all: initial;
        min-width: 0;
        box-shadow: inset 0 -3px transparent;
        padding: 6px 18px;
        margin: 6px 3px;
        border-radius: 4px;
        background-color: #1e1e2e;
        color: #cdd6f4;
      }
      
      #workspaces button.active {
        color: #1e1e2e;
        background-color: #cdd6f4;
      }
      
      #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
        color: #1e1e2e;
        background-color: #cdd6f4;
      }
      
      #workspaces button.urgent {
        background-color: #f38ba8;
      }
      
      #memory,
      #window,
      #custom-power,
      #battery,
      #backlight,
      #pulseaudio,
      #network,
      #clock,
      #bluetooth,
      #language,
      #tray {
        border-radius: 4px;
        margin: 6px 3px;
        padding: 6px 12px;
        background-color: #1e1e2e;
        color: #181825;
      }
      
      #custom-power {
        margin-right: 6px;
      }
      
      #memory {
        background-color: #fab387;
      }
      
      #battery {
        background-color: #f38ba8;
      }
      
      @keyframes blink {
        to {
          background-color: #f38ba8;
          color: #181825;
        }
      }
      
      #battery.warning,
      #battery.critical,
      #battery.urgent {
        background-color: #ff0048;
        color: #181825;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
      #window{
        background-color: #f2cdcd;
      }border: none;
        border-radius: 0;
        min-height: 0;
        font-family: JetBrainsMono Nerd Font;
        font-size: 13px;
      }
      
      window#waybar {
        background-color: #181825;
        transition-property: background-color;
        transition-duration: 0.5s;
      }
      
      window#waybar.hidden {
        opacity: 0.5;
      }
      
      #workspaces {
        background-color: transparent;
      }
      
      #workspaces button {
        all: initial;
        min-width: 0;
        box-shadow: inset 0 -3px transparent;
        padding: 6px 18px;
        margin: 6px 3px;
        border-radius: 4px;
        background-color: #1e1e2e;
        color: #cdd6f4;
      }
      
      #workspaces button.active {
        color: #1e1e2e;
        background-color: #cdd6f4;
      }
      
      #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
        color: #1e1e2e;
        background-color: #cdd6f4;
      }
      
      #workspaces button.urgent {
        background-color: #f38ba8;
      }
      
      #memory,
      #window,
      #custom-power,
      #battery,
      #backlight,
      #pulseaudio,
      #network,
      #clock,
      #bluetooth,
      #language,
      #tray {
        border-radius: 4px;
        margin: 6px 3px;
        padding: 6px 12px;
        background-color: #1e1e2e;
        color: #181825;
      }
      
      #custom-power {
        margin-right: 6px;
      }
      
      #memory {
        background-color: #fab387;
      }
      
      #battery {
        background-color: #f38ba8;
      }
      
      @keyframes blink {
        to {
          background-color: #f38ba8;
          color: #181825;
        }
      }
      
      #battery.warning,
      #battery.critical,
      #battery.urgent {
        background-color: #ff0048;
        color: #181825;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
      #window{
        background-color: #f2cdcd;
      }
      
      #language{
        background-color: #e095d9;
      }
      
      #battery.charging {
        background-color: #a6e3a1;
      }
      
      #backlight {
        background-color: #fab387;
      }
      
      #pulseaudio {
        background-color: #f9e2af;
      }
      
      #network {
        background-color: #94e2d5;
        padding-right: 17px;
      }
      
      #clock {
        font-family: JetBrainsMono Nerd Font;
        background-color: #cba6f7;
      }
      
      #bluetooth {
        background-color: #87b4fb;
      }
      
      
      tooltip {
        border-radius: 8px;
        padding: 15px;
        background-color: #131822;
      }
      
      tooltip label {
        padding: 5px;
        background-color: #131822;
      }
      #battery.charging {
        background-color: #a6e3a1;
      }
      
      #backlight {
        background-color: #fab387;
      }
      
      #pulseaudio {
        background-color: #f9e2af;
      }
      
      #network {
        background-color: #94e2d5;
        padding-right: 17px;
      }
      
      #clock {
        font-family: JetBrainsMono Nerd Font;
        background-color: #cba6f7;
      }
      
      #bluetooth {
        background-color: #87b4fb;
      }
      
      
      tooltip {
        border-radius: 8px;
        padding: 15px;
        background-color: #131822;
      }
      
      tooltip label {
        padding: 5px;
        background-color: #131822;
      }
    '';

    programs.vscode.enable = true;
    programs.vscode.userSettings = {
      "workbench.colorTheme" = "Catppuccin Mocha";
      "editor.minimap.enabled" = false;
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;
      "files.autoSave" = "afterDelay";
      "workbench.iconTheme" = "catppuccin-mocha";
      "window.menuBarVisibility" = "toggle";
      "workbench.activityBar.location" = "bottom";
      "workbench.layoutControl.enabled" = false;
      "window.commandCenter" = false;
      "css.validate" = false;
      };

    programs.vscode.extensions = with pkgs.vscode-extensions; [catppuccin.catppuccin-vsc catppuccin.catppuccin-vsc-icons jnoortheen.nix-ide];

    };
  }
