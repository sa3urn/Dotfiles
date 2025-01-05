{inputs, outputs, config, pkgs, ... }:
let

  ###  PKGS ###
  mypkgs = with pkgs; [
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
    qbittorrent
  ];

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
  environment.systemPackages = mypkgs;
  

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
    settings = {
      General = {
        Name = "Thinkpad L15";
        ControllerMode = "dual";
        FastConnectable = "true";
        Experimental = "true";
      };
      Policy = {AutoEnable = "true";};
      LE = {EnableAdvMonInterleaveScan = "true";};
    };
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
      START_CHARGE_THRESH_BAT0      = 70;
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
    cd ~/Dotfiles
    git init
    git remote rm origin
    git remote add origin git@github.com:sa3urn/Dotfiles.git
    '';

    dotcommit  = ''
    cd ~/Dotfiles
    git add .
    git commit -m 'commit'
    git push -u origin main
    '';

    nixreb = ''
    sudo cp -r /home/${user-name}/Dotfiles/configuration.nix /etc/nixos/
    sudo nixos-rebuild switch
    '';

    delgar = ''
    sudo nix-collect-garbage --delete-older-than 1d
    '';

    c = ''
    clear
    '';

    hyprreb = ''hyprctl dispatch exit'';
  };

  ### HOME MANAGER OPTIONS ###
  home-manager.users.${user-name} = { pkgs, ... }: {
    home.stateVersion = nix-version;

    ### WAYBAR ###
    programs.waybar = {
      enable = true;
      settings.mainBar = {
        layer = "top";
        position = "bottom";
        spacing = 0;
        height = 40;
        width = 1200;
        margin-bottom = 5;
        modules-left = ["custom/separator" "clock" "custom/separator" "hyprland/workspaces" "custom/separator" ];
        modules-center = ["custom/spotify-metadata"];
        modules-right = ["custom/separator" "hyprland/language" "custom/separator"  "network" "custom/separator" "bluetooth" "custom/separator" "pulseaudio" "custom/separator" "battery" "custom/separator"];

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
          "persistent-workspaces"= {
             "*" = 5;
          };
        };  

        "custom/spotify-metadata"= {
          format = "{}";
          max-length = 30;
          interval = 1;
          on-click = "kitty --class menu spotify_player";
          return-type = "json";
          exec = ''status=$(playerctl status); artist=$(playerctl metadata artist); title=$(playerctl metadata title); [[ -z $status ]] && exit; [[ $status == "Playing" ]] && { [[ -z $artist && -z $title ]] && echo "{\"class\": \"playing\", \"text\": \"\"}" || echo "{\"class\": \"playing\", \"text\": \" $artist - $title\"}"; pkill -RTMIN+5 waybar; exit; }; [[ $status == "Paused" ]] && { [[ -z $artist && -z $title ]] && echo "{\"class\": \"paused\", \"text\": \"\"}" || echo "{\"class\": \"paused\", \"text\": \" $artist - $title\"}"; pkill -RTMIN+5 waybar; exit; }'';
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
          on-click = "kitty --czlass menu bluetui";
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
          font-family: ${font};
          font-size: 13px;
          color: ${colors.text};
        }
        
        window#waybar {
        background-color: ${colors.background};
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

    ### GTK ###
    gtk = {
      enable = true;
      cursorTheme.size = 22;
      cursorTheme.name = "Bibata-Modern-Ice";
      cursorTheme.package = pkgs.bibata-cursors;
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
          "editor.fontFamily" = font;
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
          "AREPL.showFooter" = false;
      };

      extensions = with pkgs.vscode-extensions; [
          catppuccin.catppuccin-vsc-icons
          alefragnani.project-manager
          catppuccin.catppuccin-vsc
          jnoortheen.nix-ide
          ms-python.python
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
  hardware.xone.enable = true;
  hardware.steam-hardware.enable = true;
}
