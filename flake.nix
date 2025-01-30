{
  description = "Nixos configuration";

  inputs = {
    # Default to the nixos-unstable branch
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

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
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, hyprland, swww, ... }@inputs:
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

      # configure lib
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
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
          ./system/audio/blueman.nix
          ./system/audio/pipewire.nix
          ./system/fonts.nix
          ./system/hyprland.nix
          nixos-hardware.nixosModules.framework-13-7040-amd
          ./configuration.nix
          home-manager.nixosModules.default
          hyprland.nixosModules.default
          ./system/login-manager.nix
          ./system/git.nix
          ./system/power-management.nix

          ./system/security.nix
          ./system/disk-utils.nix
          ./system/swap.nix
        ];
      };
      homeConfigurations = {
        "_2b@YoRNix" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
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
