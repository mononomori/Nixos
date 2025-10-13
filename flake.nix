{
  description = "Nixos configuration";

  inputs = {
    # Default to the nixos-unstable branch
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Used in overlays where you are defaulting to stable
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    # Enable Home-Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Used for package database in things like comma
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Used for hardware specific optimization
    nixos-hardware = {
      url = "github:NixOs/nixos-hardware/master";
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

    # vicinae = {
    #   url = "github:vicinaehq/vicinae";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # Wait for fix

    wayland-pipewire-idle-inhibit = {
      url = "github:rafaelrc7/wayland-pipewire-idle-inhibit";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    yazi-plugins = {
        url = "github:yazi-rs/plugins";
        flake = false; # This repo doesn't contain a flake.nix
    };

    yazi = {
      url = "github:sxyazi/yazi";
    } ;
    zen-browser = {
        url = "github:0xc000022070/zen-browser-flake";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, nix-index-database, nixos-hardware, hyprland, swww, ... }@inputs:
    let
      # ---- System Settings ---- #
      system = "x86_64-linux";

      permittedInsecure = [
        "adobe-reader-9.5.5"
        "dotnet-sdk-6.0.428"
        "dotnet-sdk-7.0.410"
        "dotnet-runtime-6.0.36"
        "dotnet-runtime-7.0.20"
        "electron-27.3.11"
        "electron-28.2.10"
        "libxml2-2.13.8"
      ];

      overlays = {
        stable-packages = final: _prev: {
          stable = import inputs.nixpkgs-stable {
            inherit (final) system config;
          };
        };
      };
    in
    {
      nixosConfigurations = {
        YoRNix = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            inherit inputs;
            hostname = "YoRNix";
            diskusers = [ "_2b" ];
            videousers = [ "_2b" ];
            gitusers = [ 
              {
                name = "mononomori";
                email = "miguel.a.cannuli@gmail.com";
              }
            ];
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
            ./hosts/YoRNix/configuration.nix
            nixos-hardware.nixosModules.framework-13-7040-amd
            home-manager.nixosModules.default
            hyprland.nixosModules.default
            nix-index-database.nixosModules.nix-index
            { programs.nix-index-database.comma.enable = true; }


          ];
        };
      };
    };
}
