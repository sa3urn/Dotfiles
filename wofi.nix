{ config, pkgs, ... }:

{
  home-manager.users.q3e4ir = { pkgs, ... }: {
    programs.wofi.enable = true;
    programs.wofi.settings = {
      show="drun";
      width="50%";
      height="40%";
      location="center";
      always_parse_args=true;
      allow_markup=false;
      show_all=true;
      term="kitty";
      hide_scroll=false;
      print_command=true;
      insensitive=true;
      prompt="drun";
      columns=3;
      allow_images=false;
      no_actions = true;
    };
    programs.wofi.style = ''
    * {
      font-family: 'JetBrainsMono Nerd Font', monospace;
      font-size: 14px;
    }
    window {
      margin: 0px;
      padding: 10px;
      border: 0.16em solid #b4befe;
      border-radius: 0.1em;
      background-color: #1f2335;
      animation: slideIn 0.5s ease-in-out both;
    }
    @keyframes slideIn {
      0% {
        opacity: 0;
      }

      100% {
        opacity: 1;
      }
    }

    #inner-box {
      margin: 5px;
      padding: 10px;
      border: none;
      background-color: #1f2335;
      animation: fadeIn 0.5s ease-in-out both;
    }

    @keyframes fadeIn {
      0% {
        opacity: 0;
      }

      100% {
        opacity: 1;
      }
    }

    #outer-box {
      margin: 5px;
      padding: 10px;
      border: none;
      background-color: #1f2335;
    }

    #scroll {
      margin: 0px;
      padding: 10px;
      border: none;
      background-color: #1f2335;
    }

    #input {
      margin: 5px 20px;
      padding: 10px;
      border: none;
      border-radius: 0.1em;
      color: #c0caf5;
      background-color: #1f2335;
      animation: fadeIn 0.5s ease-in-out both;
    }

    #input image {
        border: none;
        color: #c53b53 ;
    }

    #text {
      margin: 5px;
      border: none;
      color: #c0caf5;
      animation: fadeIn 0.5s ease-in-out both;
    }

    #entry {
      background-color: #1f2335;
    }

    #entry arrow {
      border: none;
      color: #3d59a1 ;
    }

    #entry:selected {
      border: 0.11em solid #3d59a1 ;
    }

    #entry:selected #text {
      color: ;
      background-color: #1f2335;
    }
    '';
  };
}
