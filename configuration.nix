{ config, pkgs, ... }:
let
  user-name = "sa3urn";
  nix-version = "24.11";

  color-waybar = "rgba(10, 10, 20, 0.7)";
  color-darkgrey = "#181926";

  color-cream = "#f5e0dc";
  color-lightgrey = "#cdd6f4";
  color-grey = "#6c7086";
  color-black = "#45475a";
  color-red = "#f38ba8";
  color-green = "#a6e3a1";
  color-yellow = "#f9e2af";
  color-blue = "#89b4fa";
  color-magenta = "#f5c2e7";
  color-cyan = "#94e2d5";
  color-white = "#bac2de";
in 
{
  ### IMPORTS ###
  imports = [
    <home-manager/nixos>
    ./hardware-configuration.nix 
  ];
  
  ### BOOT LOADER ###
  boot.loader = {
    systemd-boot.enable      = true;
    efi.canTouchEfiVariables = true;
  };

  ### USER ###
  users.users.${user-name} = {
    isNormalUser = true;
    extraGroups  = ["audio" "networkmanager" "wheel" ];
  };
 
  ### AUTOLOGIN ###
  services = {
    getty.autologinUser = user-name;
    greetd = {
      enable = true;
      settings.default_session = {
        user    = user-name;
        command = "Hyprland";
      };
    };
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

  ### PACKAGES ###
  environment.systemPackages = with pkgs; [
    waybar
    hyprpaper
    git
    unzip
    pulseaudio
    firefox
    vscodium
    kitty
    tg
    pulsemixer
    bibata-cursors
    impala
    bluetui
    sway-launcher-desktop 
    xdg-utils
    playerctl
    spotify-player
    steam-tui
    steamcmd
  ];

  programs.hyprland.enable = true;

  ### FONTS ###
  fonts.packages = with pkgs; [(nerdfonts.override {fonts = ["JetBrainsMono"];})];

  ### SOUND ###
  services.pipewire = {
    enable            = true;
    audio.enable      = true;
    jack.enable       = true;
    pulse.enable      = true;
    alsa.enable       = true;
    alsa.support32Bit = true;
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

  ### BLUETHOOTH ###
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  ### TLP ###
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC    = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT   = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC  = "performance";
      CPU_MIN_PERF_ON_AC            = 0;
      CPU_MAX_PERF_ON_AC            = 100;
      CPU_MIN_PERF_ON_BAT           = 0;
      CPU_MAX_PERF_ON_BAT           = 20;
      START_CHARGE_THRESH_BAT0      = 50;
      STOP_CHARGE_THRESH_BAT0       = 80;
    };
  };

  ### POLKIT ###
  security.polkit = {
    enable = true;
    extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (subject.isInGroup("wheel"))
        return polkit.Result.YES;
      });
    '';
  };

  ### ALIASES ###
  programs.bash.shellAliases = {
    sshlog = ''
    ssh-keygen -t rsa -b 4096 -P "" -f /home/sa3urn/.ssh/id_rsa
    cat ~/.ssh/id_rsa.pub; echo 'https://github.com/settings/ssh/new'
    read -p 'apply ssh-key' apply
    cd ~/dotfiles
    git init
    git remote rm origin
    git remote add origin git@github.com:sa3urn/dotfiles.git
    '';

    dotcommit  = ''
    cd ~/dotfiles
    git add .
    git commit -m 'commit'
    git push -u origin main
    '';

    nixreb = ''
    sudo cp -r /home/${user-name}/dotfiles/configuration.nix /etc/nixos/
    sudo nixos-rebuild switch --upgrade
    '';

    delgar = ''
    sudo nix-collect-garbage --delete-older-than 1d
    '';

    c = ''
    clear
    '';
  };

  ### HOME MANAGER OPTIONS ###
  home-manager.users.${user-name} = { pkgs, ... }: {
    home.stateVersion = nix-version;

    ### WAYLAND ###
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {

        monitor = ",preferred,auto,1";

        input = {
          kb_layout = "us,ru";
          kb_options = "grp:win_space_toggle";
          repeat_delay = 300;
          repeat_rate = 50;
          follow_mouse = 1;
          sensitivity = -0.1;

          touchpad = {
              natural_scroll = true;
              disable_while_typing = false;
              scroll_factor = 0.2;
          };
        };

        gestures = {
          workspace_swipe = "on";
          workspace_swipe_forever = "true";

        };

        general = {
          gaps_in = 0;
          gaps_out = 0;
          border_size = 0;
          layout = "dwindle";
          allow_tearing = false;
        };

        dwindle = {
          pseudotile = "yes";
          preserve_split = "yes";
        };

        decoration = {
          rounding = 0;
          active_opacity = 0.95;
          inactive_opacity = 0.95;

          blur = {
            enabled = true;
            size = 3;
            passes = 1;
          };
        };

        animations = {
          enabled = "yes";
          bezier = "myBezier, 1, 1, 1, 1";

          animation = [
            "windows, 1, 1, myBezier"
            "windowsOut, 1, 1, default, popin 80%"
            "border, 1, 1, default"
            "borderangle, 1, 1, default"
            "fade, 1, 1, default"
            "workspaces, 1, 1, default"
          ];
        };

        misc = {
          force_default_wallpaper = 0 ;
          disable_splash_rendering = true;
          disable_hyprland_logo = true;
        };

        exec-once = ["hyprctl setcursor Bibata-Modern-Ice 22" "hyprpaper" "waybar" "firefox" "kitty --class Spotify spotify_player" "codium"];

        windowrule = [
          "workspace 1, VSCodium"
          "workspace 2, firefox"
          "workspace 3, Spotify"
          "workspace 3, org.telegram.desktop"
          "workspace 4, steam"

          "float, menu"
          "size 1000 600, menu"
          "move 920 38, menu"
          "pin, menu"
          "stayfocused, menu"
        ];

        bind = [
        "SUPER, A, exec, kitty --class menu sway-launcher-desktop"
        "SUPER, W, killactive"

        "SUPER, S, exec, kitty --class menu pulsemixer"
        "SUPER, B, exec, kitty --class menu bluetui"
        "SUPER, N, exec, kitty --class menu impala"

        "SUPER, T, exec, kitty --class menu tg"
        "SUPER, F, exec, firefox"
        "SUPER, Return, exec, kitty"
        "SUPER, M, exec, kitty --class menu spotify_player"

        "SUPER, Left, movefocus, l"
        "SUPER, Right, movefocus, r"
        "SUPER, Up, movefocus, u"
        "SUPER, Down, movefocus, d"
        
        "SUPER SHIFT, Left, movewindow, l"
        "SUPER SHIFT, Right, movewindow, r"
        "SUPER SHIFT, Up, movewindow, u"
        "SUPER SHIFT, Down, movewindow, d"

        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"
        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"
        "SUPER SHIFT, 0, movetoworkspace, 10"
        "SUPER, mouse_down, workspace, +1"
        "SUPER, mouse_up, workspace, -1"
        ];
        binde = [
          "SUPER CTRL, Left, resizeactive, -50 0"
          "SUPER CTRL, Right, resizeactive, 50 0"
          "SUPER CTRL, Up, resizeactive, 0 -50"
          "SUPER CTRL, Down, resizeactive, 0 50"

          "SHIFT, Up, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
          "SHIFT, Down, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
          "SHIFT, Right, exec, playerctl next"
          "SHIFT, Left, exec, playerctl previous"
          "SUPER, P, exec, playerctl play-pause"
        ];
      };
    };

    ### WAYBAR ###
    programs.waybar = {
      enable = true;
      settings.mainBar = {
        layer = "top";
        position = "top";
        spacing = 0;
        height = 38;
        modules-left = ["clock" "custom/separator" "hyprland/workspaces"];
        modules-center = ["custom/spotify-metadata"];
        modules-right = ["hyprland/language" "custom/separator" "custom/search" "custom/separator" "network" "custom/separator" "bluetooth" "custom/separator" "pulseaudio" "custom/separator" "battery"];

        "clock" = {
          format = "{:%I:%M %p}";
          timezone = "Europe/Kyiv";
        };

        "custom/separator"= {
          format = "";
          interval = "once";
          tooltip  = false;
        };

        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          format-icons = {
            active = "";
            default = "";
          };
        };  

        "custom/spotify-metadata"= {
          format = "{}";
          max-length = 60;
          interval = 1;
          on-click = "kitty --class menu spotify_player";
          return-type = "json";
          exec = ''status=$(playerctl status); artist=$(playerctl metadata xesam:artist); title=$(playerctl metadata xesam:title); [[ -z $status ]] && exit; [[ $status == "Playing" ]] && echo "{\"class\": \"playing\", \"text\": \" $artist - $title\"}" && pkill -RTMIN+5 waybar && exit; [[ $status == "Paused" ]] && echo "{\"class\": \"paused\", \"text\": \" $artist - $title\"}" && pkill -RTMIN+5 waybar && exit'';
        };

        "custom/search"= {
          format = "   ";
          interval = "once";
          on-click = "kitty --class menu sway-launcher-desktop";
          tooltip  = false;
        };

        "hyprland/language" = {
          format = "  {short}";
        };

        "network" = {
          format-wifi = "{icon}";
          format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          format-ethernet = "󰀂 " ;
          format-disconnected = "󱘖 ";
          on-click = "kitty --class menu impala";
          interval = 5;
          nospacing = 1;
          tooltip = false;
        };

        "bluetooth" = {
          format-on = "󰂯";
          format-off = "󰂲";
          format-disabled = "󰂲";
          format-connected = "󰂱";
          format-connected-battery = "󰂱 {device_battery_percentage}%";
          on-click = "kitty --class menu bluetui";
        };
        "pulseaudio" = {
          format = "{icon}  {volume}%";
          format-muted = "󰝟";
          format-icons = {
            default = ["󰖀" "󰕾" ""];
          };
          on-click = "kitty --class menu pulsemixer";
          smooth-scrolling-threshold=0;
          scroll-step = 0;
          tooltip = false;
        };

        "battery" = {
          format = "{icon} {capacity}%";
          format-icons = {
            charging = ["󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
            default = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          };
          interval = 1;
          tooltip = false;
          states = {
            warning = 20;
            critical = 10;
          };
        };
      };

      style = ''
      * {
          font-family: JetBrainsMono Nerd Font;
          font-size: 13px;
          color: ${color-white};
        }
        
        window#waybar {
        background-color: ${color-waybar};
        }
        
        #window,
        #battery,
        #pulseaudio,
        #network,
        #clock,
        #bluetooth,
        #language,
        #mpd,
        #workspaces button {
          padding: 6px 12px;
          background-color: transparent;
        }   
      '';
    };

    ### HYPRPAPER ###
    services.hyprpaper = {
      enable = true;
      settings = { 
        preload = "/home/${user-name}/wallpaper.jpg";
        wallpaper = "eDP-1, /home/${user-name}/wallpaper.jpg";
      };
    };

    ### GTK ###
    gtk = {
      enable = true;
      cursorTheme.size = 22;
      cursorTheme.name = "Bibata-Modern-Ice";
      cursorTheme.package = pkgs.bibata-cursors;
    };

    ### KITTY ###
    programs.kitty = {
      enable = true;
      settings = {
        foreground             = color-lightgrey;
        background             = color-darkgrey;
        selection_foreground   = color-darkgrey;
        selection_background   = color-cream;
        cursor                  = color-cream;
        cursor_text_color       = color-darkgrey;
        url_color               = color-cream;
        active_border_color     = color-lightgrey;
        inactive_border_color   = color-grey;
        bell_border_color       = color-yellow;
        active_tab_foreground   = color-darkgrey;
        active_tab_background   = color-magenta;
        inactive_tab_foreground = color-lightgrey;
        inactive_tab_background = color-darkgrey;
        tab_bar_background      = color-darkgrey;
        mark1_foreground        = color-darkgrey;
        mark1_background        = color-lightgrey;
        mark2_foreground        = color-darkgrey;
        mark2_background        = color-magenta;
        mark3_foreground        = color-darkgrey;
        mark3_background        = color-blue;
        color0                  = color-black;
        color8                  = color-black;
        color1                  = color-red;
        color9                  = color-red;
        color2                  = color-green;
        color10                 = color-green;
        color3                  = color-yellow;
        color11                 = color-yellow;
        color4                  = color-blue;
        color12                 = color-blue;
        color5                  = color-magenta;
        color13                 = color-magenta;
        color6                  = color-cyan;
        color14                 = color-cyan;
        color7                  = color-white;
        color15                 = color-white;
        font_size               = 12;
        font_family             = "JetBrainsMono Nerd Font";
        confirm_os_window_close = 0;
        resize_debounce_time    = 0;
      };
    };

    ### GIT ###
    programs.git = {
      enable = true;
      userEmail = "durychyaroslav@gmail.com";
      userName = user-name;
    };

    ### VSCODIUM ###
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;

      userSettings = {
          "editor.minimap.enabled" = false;
          "editor.fontFamily" = "JetBrainsMono Nerd Font";
          "explorer.confirmDelete" = false;
          "explorer.confirmDragAndDrop" = false;
          "files.autoSave" = "afterDelay";
          "window.menuBarVisibility" = "toggle";
          "workbench.colorTheme" = "Catppuccin Mocha";
          "workbench.iconTheme" = "catppuccin-mocha";
          "window.customTitleBarVisibility" = "auto";
          "workbench.statusBar.visible" = false;
          "workbench.activityBar.location" = "bottom";
          "terminal.integrated.fontFamily" = "monospace";
      };

      extensions = with pkgs.vscode-extensions; [
          catppuccin.catppuccin-vsc-icons
          alefragnani.project-manager
          catppuccin.catppuccin-vsc
          jnoortheen.nix-ide
      ];
    };
  };

  ### STEAM ###
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; 
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;
  };
}
