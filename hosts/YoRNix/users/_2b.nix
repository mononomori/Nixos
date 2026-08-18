{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  imports = [
    ../../../modules/home-manager/hypr/hyprland.nix
    ../../../modules/home-manager/hypr/hyprland-env.nix
    ../../../modules/home-manager/hypr/hypridle.nix
    ../../../modules/home-manager/hypr/hyprlock.nix
    ../../../modules/home-manager/hypr/waybar.nix
    ../../../modules/home-manager/fish.nix
    ../../../modules/home-manager/fuzzel.nix
    ../../../modules/home-manager/gimp.nix
    ../../../modules/home-manager/kitty.nix
    ../../../modules/home-manager/media/mpv.nix
    ../../../modules/home-manager/media/rmpc.nix
    ../../../modules/home-manager/neovim.nix
    ../../../modules/home-manager/ssh-hosts.nix
    ../../../modules/home-manager/vesktop/vesktop.nix
    ../../../modules/home-manager/vscode.nix
    ../../../modules/home-manager/yazi.nix
    ../../../modules/home-manager/zen-browser.nix
    inputs.wayland-pipewire-idle-inhibit.homeModules.default
    # inputs.vicinae.homeManagerModules.default (wait for fix)
  ];

  # services.vicinae = {
  #   enable = true;
  # };
  # (wait for fix)

  # Home Manager needs a bit of information about you and the paths it should manage.
  home = {
    username = "_2b";
    homeDirectory = "/home/_2b";
    sessionPath = [ ];
  };

  #---------------------------------------------------------------------
  # Secrets
  #---------------------------------------------------------------------

  # Identity used to decrypt agenix secrets in this home-manager config
  age.identityPaths = [ "/home/_2b/.ssh/id_ed25519_agenix" ];

  #---------------------------------------------------------------------
  # Packages
  #---------------------------------------------------------------------

  home.packages = builtins.attrValues {
    inherit (pkgs)
      aseprite
      astroterm
      hollywood
      fluent-reader
      wf-recorder
      pastel
      profanity
      samira
      scanmem
      libreoffice
      prismlauncher
      slipstream
      unityhub
      winetricks
      zotero
      darktable
      ;

    wine = pkgs.wineWow64Packages.waylandFull;
  };

  #---------------------------------------------------------------------
  # Files
  #---------------------------------------------------------------------

  xdg.mimeApps.enable = true;

  home.file = {
    # Symlink my power menu script so it's runnable as a command and shows up in dmenu/fuzzel
    ".local/bin/power-menu".source =
      config.lib.file.mkOutOfStoreSymlink "/etc/nixos/modules/home-manager/scripts/fuzzel-power-menu.sh";
  };

  #---------------------------------------------------------------------
  # Desktop appearance
  #---------------------------------------------------------------------

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

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

    gtk4 = {
      theme = config.gtk.theme;
      extraConfig = {
        "gtk-application-prefer-dark-theme" = "1";
        "gtk-cursor-theme-name" = "Bibata-Modern-Classic";
      };
    };
  };

  #---------------------------------------------------------------------
  # Session variables
  #---------------------------------------------------------------------

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    NIXOS_XDG_OPEN_USE_PORTAL = "1";
  };

  programs.home-manager.enable = true;

  # Please read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  # Before changing this value, as it may break your configuration if you set it incorrectly.
  home.stateVersion = "23.11";
}