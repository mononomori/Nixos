# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, inputs, ... }:

{
  imports = [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  #### Extra Options and Flakes
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than +7";
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
    kernelModules = [ "iwlwifi" ];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        memtest86.enable = true;
        configurationLimit = 7;
      };
    };
  };
  

  # Firmware updates.
  hardware.firmware = [ pkgs.linux-firmware ];
  services.fwupd.enable = true;

  # Power Management.
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking and setup hostname
  networking = {
    hostName = "YoRNix";
    networkmanager = {
      enable = true;
      wifi.powersave = false;
      wifi.backend = "iwd";
    };
    wireless.iwd.enable = true;
    wireless.iwd.settings = {
      Network = {
        EnableIPv6 = true;
        RoutePriorityOffset = 300;
      };
      Settings = {
        AutoConnect = true;
      };
    };
    nameservers = [
      "1.1.1.1"
      "9.9.9.9"
      "4.4.4.4"
      "8.8.8.8"
      "8.8.4.4"
    ];
  };


  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable firewall and open TCP/UDP ports.
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 ];
    allowedUDPPortRanges = [
      { from = 4000; to = 4007; }
      { from = 8000; to = 8010; }
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Set your time zone.

  time.timeZone = "America/Vancouver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Shell
  programs.fish.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  # services.xserver.desktopManager.plasma5.enable = true;





 



  environment.localBinInPath = true;

  #### Graphics Drivers:
   hardware.graphics = {
     enable = true;
     enable32Bit = true;

  };


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define user’.
  users.users._2b = {
    isNormalUser = true;
    description = "_2b";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      kate
    # thunderbird
    ];
    shell = pkgs.fish;
  };


  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "backup";
    users = {
      "_2b" = import ./user/home.nix;
    };
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-28.2.10"
    "adobe-reader-9.5.5"
    "dotnet-sdk-7.0.410"
    "dotnet-runtime-7.0.20"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #### Browser:
    (google-chrome.override {
       commandLineArgs = [
          "--enable-features-UseOzonePlatform"
          "--ozone-platform=wayland"
	      ];
    })
    chromium
    adobe-reader

    #### Communication:
    caprine-bin
    discord
    webcord
    zoom-us 


    #### Compilation:
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
    gcc
    glib
    glibc
    gnumake
    inklecate
    killall
    openjdk
    postgresql
    zig
    
    #### Desktop:
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
    power-profiles-daemon
    swww

    wl-clipboard



    #### Developer Tools:
    vscode-fhs    
    staruml
    unityhub    
    
    #### File Utility:
    fd
    flatpak
    fzf
    gh
    gnome-terminal
    nemo
    nnn
    unzip
    wget
    yazi
    zip
    zoxide
    xdragon


    #### Gaming:
    bolt-launcher
    gamescope
    freesweep
    steam
    ttyper
    vitetris

    #### Network:
    networkmanager
    networkmanagerapplet
    networkmanager_dmenu

    #### Terminal:
    fish
  
    #### Terminal Utilities:
    cbonsai
    htop
    neofetch
    powertop
    wev

    #### Text Utility:
    helix
    nano
    neovim
    obsidian
    vim
    emacs
  ];

  # Steam:
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # Power Profiles:
  services.power-profiles-daemon.enable = true;

  programs.nm-applet.enable = true;

  services.flatpak.enable = true;


  
  # Fonts:


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
