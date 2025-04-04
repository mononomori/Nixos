{
  description = "Nixos configuration";

  inputs = {
    # Default to the nixos-unstable branch
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Used in overlays where you are defaulting to stable
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";


    # Hardware pkgs
    nixos-hardware = {
      url = "github:NixOs/nixos-hardware/master";
    };
    # Enable home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Latest version of Hyprland
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    swww = {
      url = "github:LGFae/swww";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
        url = "github:0xc000022070/zen-browser-flake";
    };

    yazi-plugins = {
        url = "github:yazi-rs/plugins";
        flake = false; # This repo doesn't contain a flake.nix
    };

    yazi.url = "github:sxyazi/yazi";



  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, nixos-hardware, hyprland, swww, ... }@inputs:
    let
      # ---- System Settings ---- #
      system = "x86_64-linux";
      hostname = "YoRNix";
      username = "_2b";
      diskusers = [ "_2b" ];
      gitusers = [
        { 
          name = "monomori"; 
          email = "miguel.a.cannuli@gmail.com";
        }
      ];

      permittedInsecure = [
        "electron-27.3.11"
        "electron-28.2.10"
        "adobe-reader-9.5.5"
        "dotnet-sdk-7.0.410"
        "dotnet-runtime-7.0.20"
      ];

      overlays = {
        stable-packages = final: _prev: {
          stable = import inputs.nixpkgs-stable {
            system = final.system;
            config = {
              allowUnfree = true;
              permittedInsecurePackages = permittedInsecure;
            };
          };
        };
      };

    in
    {
      nixosConfigurations.YoRNix = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit hostname;
          inherit inputs;
          inherit system;
          inherit username;
          inherit diskusers;
          inherit gitusers;

        };
        modules = [ 
          {
            nixpkgs = {
              config = {
                allowUnfree = true;
                permittedInsecurePackages = permittedInsecure;
              };
              overlays = [ overlays.stable-packages ];
            };
          }
          ./system/audio/blueman.nix
          ./system/audio/pipewire.nix
          ./system/fonts/fonts.nix
          ./system/hyprland.nix
          nixos-hardware.nixosModules.framework-13-7040-amd
          ./configuration.nix
          home-manager.nixosModules.default
          hyprland.nixosModules.default
          ./system/login-manager.nix
          ./system/git.nix
          ./system/power-management.nix
          ./system/networking.nix
          ./system/security.nix
          ./system/disk/disk-utils.nix
          ./system/disk/swap.nix
          ./system/disk/file-systems.nix
          ./system/disk/snapper.nix
        ];
      };
      homeConfigurations = {
        "_2b@YoRNix" = home-manager.lib.homeManagerConfiguration {
          inherit hostname;
          inherit system;
          inherit inputs;
          modules = [
            ./user/home.nix
          ];
        };
      };
    };
}
