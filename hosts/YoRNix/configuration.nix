{ config, lib, pkgs, inputs, system, hostname, ... }:

{
  imports = [
    # Include the results of the hardware scan:
    ./hardware-configuration.nix
    # Modules:
    ../../modules/nixos/audio/blueman.nix
    ../../modules/nixos/audio/pipewire.nix
    ../../modules/nixos/disk/disk-users.nix
    ../../modules/nixos/disk/disk-utils.nix
    ../../modules/nixos/disk/file-systems.nix
    ../../modules/nixos/disk/swap.nix
    ../../modules/nixos/disk/snapper.nix
    ../../modules/nixos/fonts/fonts.nix
    ../../modules/nixos/git.nix
    ../../modules/nixos/hyprland.nix
    ../../modules/nixos/login-manager.nix
    ../../modules/nixos/networking.nix
    ../../modules/nixos/power-management.nix
    ../../modules/nixos/security.nix
    ../../modules/nixos/steam.nix
    ../../modules/nixos/video-users.nix
  ];
  
  #### Extra Options and Flakes
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    optimise = {
      automatic = true;
    };
    settings = {
      experimental-features = [ "nix-command" "flakes"];
      warn-dirty = false;
      auto-optimise-store = true;
    };
  };   

  # Bootloader
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        memtest86.enable = true;
        configurationLimit = 7;
      };
    };
    initrd.supportedFilesystems = [ "btrfs" ];
  };

  # Firmware updates.
  hardware.firmware = [ pkgs.linux-firmware ];
  services.fwupd.enable = true;

  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Shell
  programs.fish.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  # services.xserver.desktopManager.plasma5.enable = true;

  environment.localBinInPath = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [
      pkgs.gutenprint
      pkgs.hplip
      pkgs.hplipWithPlugin
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define user’.
  users.users._2b = {
    isNormalUser = true;
    description = "_2b";
    extraGroups = lib.mkBefore [ "networkmanager" "wheel" ];
    group = "_2b";
    packages = builtins.attrValues {
      inherit (pkgs) firefox;
    };
    shell = pkgs.fish;
  };
  users.groups."_2b" = {};

  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = { 
      inherit inputs;
      inherit hostname;
      inherit system;
    };
    backupFileExtension = "backup";
    users = {
      "_2b" = import ./users/_2b.nix;
    };
  };
 
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      # ==== Browsers ====
      chromium

      # ==== Communication ====
      caprine-bin
      discord
      webcord
      zoom-us

      # ==== Compilation ====
      bash
      bc
      cachix
      clang
      dotnet-sdk_7
      dotnet-sdk
      dotnet-sdk_8
      dotnet-runtime
      dotnet-runtime_7
      dotnet-runtime_8
      python3
      gcc
      glib
      glibc
      gnumake
      inklecate
      killall
      openjdk
      postgresql
      zig
      fwupd
      nodejs
      comma
      nix-index

      # ==== Desktop ====
      asciiquarium-transparent
      brightnessctl
      catppuccin-cursors
      clipse
      dunst
      gtk2
      gtk3
      gtk4
      libnotify
      neo
      swww
      wl-clipboard

      # ==== Developer Tools ====
      fontforge
      inkscape
      vscode-fhs    
      staruml
      unityhub    
      blender
      quickemu
      spice
      poetry

      # ==== File Utility ====
      adobe-reader
      fd
      flatpak
      fzf
      gh
      gnome-terminal
      nemo
      nnn
      p7zip
      unrar
      unzip
      wget
      zathura
      zip
      zoxide
      foliate

      # ==== Gaming ====
      bolt-launcher
      freesweep
      ttyper
      vitetris

      # ==== Terminal ====
      fish

      # ==== Terminal Utilities ====
      cbonsai
      calcurse
      htop
      neofetch
      wev
      fastfetch
      nix-prefetch
      starship
      basilk
      cava
      wttrbar

      # ==== Text Utility ====
      helix
      nano
      neovim
      micro
      obsidian
      logseq
      vim
      emacs
      pokemonsay
      cowsay
      fortune

      # ==== Printing ====
      gutenprint
    ;

    # ==== Browsers: Custom/Inputs ====
    google-chrome = pkgs.google-chrome.override {
      commandLineArgs = [
        "--enable-features-UseOzonePlatform"
        "--ozone-platform=wayland"
      ];
    };

    zen-browser-default = inputs.zen-browser.packages.${system}.default;
    zen-browser-beta = inputs.zen-browser.packages.${system}.beta;
    zen-browser-twilight = inputs.zen-browser.packages.${system}.twilight;
  };

  services.flatpak.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
