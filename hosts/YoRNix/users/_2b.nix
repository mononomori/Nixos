{ config, pkgs, lib, inputs, iosevka-iaso, ... }:

{
  imports = [
    ../../../modules/home-manager/desktop/hyprland.nix
    ../../../modules/home-manager/desktop/hyprland-env.nix
    ../../../modules/home-manager/desktop/hypridle.nix
    ../../../modules/home-manager/desktop/hyprlock.nix
    ../../../modules/home-manager/desktop/waybar.nix
    ../../../modules/home-manager/fish.nix
    ../../../modules/home-manager/fuzzel.nix
    ../../../modules/home-manager/kitty.nix
    ../../../modules/home-manager/media/mpv.nix

    ../../../modules/home-manager/yazi.nix
  ];
  
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "_2b";
  home.homeDirectory = "/home/_2b";
  home.sessionPath = [
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = [

  ];

  home.file = {
    # Symlink my power menu script so it's runnable as a command and shows up in dmenu/fuzzel
    ".local/bin/power-menu".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/modules/home-manager/scripts/fuzzel-power-menu.sh";

  };

  # Configure user specific desktop settings

  # Cursor
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };


  # GTK theming
  gtk = {
    enable = true;

    font = {
      name = "IosevkaB Extended Medium";
      size = 12;
    };

    theme = {
      name = "Orchis-Pink-Dark";
      package = pkgs.orchis-theme;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };

    gtk3.extraConfig = {
      "gtk-application-prefer-dark-theme" = "1";
      "gtk-cursor-theme-name" = "Bibata-Modern-Classic";
    };

    gtk4.extraConfig = {
      "gtk-application-prefer-dark-theme" = "1";
      "gtk-cursor-theme-name" = "Bibata-Modern-Classic";
    };

  };

  home.sessionVariables = {
  
  };

  programs.home-manager.enable = true;
}
