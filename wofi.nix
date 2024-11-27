{ config, pkgs, ... }:

{
  home-manager.users.sa3urn = { pkgs, ... }: {
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
      columns=2;
      allow_images=true;
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
      border: 0.16em solid;
      border-radius: 0.1em;
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
    }

    #scroll {
      margin: 0px;
      padding: 10px;
      border: none;
    }

    #input {
      margin: 5px 20px;
      padding: 10px;
      border: none;
      border-radius: 0.1em;
      animation: fadeIn 0.5s ease-in-out both;
    }

    #input image {
        border: none;
    }

    #text {
      margin: 5px;
      border: none;
      animation: fadeIn 0.5s ease-in-out both;
    }

    #entry arrow {
      border: none;
    }

    #entry:selected {
      border: 0.11em solid;
    }
    '';
  };
}
