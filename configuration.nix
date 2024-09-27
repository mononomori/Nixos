# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, inputs, ... }:

{
  imports = [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Include home-manager
      inputs.home-manager.nixosModules.default
    ];
  
  #### Extra Options and Flakes
  nix = {
    gc = {
      automatic = true;
      dates = "weekkly";
      options = "--delete-older-than +7";
    };
    settings = {
      experimental-features = [ "nix-command" "flakes"];
      warn-dirty = false;
      auto-optimise-store = true;
      trusted-users = [
        "root"
        "@wheel"
      ];
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

  # Enable hyprland window manager
  programs.hyprland = {
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    enable = true;
    xwayland.enable = true;
  };
  
  #### XDG:
  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };

  #### Environment Session Variables:
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_CURRENT_SESSION = "Hyprland";
  };

  #### Graphics Drivers:
   hardware.opengl = {
     enable = true;
     driSupport = true;
     driSupport32Bit = true;

  };


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

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
  # Grant user sudo permissions
  security.sudo.wheelNeedsPassword = false;

  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "hm-backup";
    users = {
      "_2b" = import ./home.nix;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #### Audio:
    bluez
    bluez-tools
    pavucontrol
    pipewire
    wireplumber

    #### Browser:
    (google-chrome.override {
       commandLineArgs = [
          "--enable-features-UseOzonePlatform"
          "--ozone-platform=wayland"
	];
    })
    chromium

    #### Communication:
    caprine-bin
    discord
    webcord
    zoom-us 


    #### Compilation:
    clang
    dotnet-sdk
    dotnet-sdk_7
    dotnet-sdk_8
    dotnet-runtime
    dotnet-runtime_7
    dotnet-runtime_8
    gcc
    glib
    glibc
    openjdk
    postgresql
    
    #### Desktop:
    brightnessctl
    catppuccin-cursors.latteLight
    clipse
    dunst
    grim
    gtk2
    gtk3
    gtk4
    hyprshot
    hyprcursor
    libnotify
    power-profiles-daemon
    rofi-wayland
    slurp
    swww
    waybar
    (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    )
    wl-clipboard
    xdg-desktop-portal
    xdg-utils

    #### Developer Tools:
    figma-linux
    vscode-fhs    
    staruml
    unityhub    
    
    #### File Utility:
    cinnamon.nemo
    flatpak
    fzf
    gh
    gnome.gnome-terminal
    nnn
    unzip
    wget
    zip

    #### Gaming:
    gamescope
    freesweep
    steam
    ttyper
    vitetris

    #### home-manager
    
    #### Network:
    networkmanager
    networkmanagerapplet

    #### Terminal:
    fish
    kitty
   
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
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    nerdfonts
  ];





  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
