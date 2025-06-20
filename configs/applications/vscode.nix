{pkgs, ...}:
let
  var = (import /home/sa3urn/Desktop/Dotfiles/variables/.).var;
in
{
  home-manager.users.${var.system.user-name} = { pkgs, ... }: {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      userSettings = {
        "editor.minimap.enabled" = false;
        "editor.fontFamily" = "Monocraft Nerd Font";
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        "files.autoSave" = "afterDelay";
        "window.menuBarVisibility" = "toggle";
        "workbench.colorTheme" = "Black++ Grey Matter";
        "workbench.iconTheme" = "catppuccin-mocha";
        "window.customTitleBarVisibility" = "auto";
        "workbench.statusBar.visible" = true;
        "workbench.activityBar.location" = "bottom";
        "terminal.integrated.fontFamily" = "monospace";
        "cmake.options.statusBarVisibility" = "visible";
        "clangd.path" = "/home/sa3urn/.config/VSCodium/User/globalStorage/llvm-vs-code-extensions.vscode-clangd/install/19.1.2/clangd_19.1.2/bin/clangd";
      };
      extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc-icons
        jnoortheen.nix-ide
      ];
    };
  };
}
