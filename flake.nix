{
  description = "Nixos configuration";

  inputs = {
    # Default to the nixos-unstable branch
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Hardware pkgs
    nixos-hardware.url = "github:NixOs/nixos-hardware/master";
    # Enable home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Latest version of Hyprland
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };



  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, hyprland, ... }@inputs:
    let
      # ---- System Settings ---- #
      system = "x86_64-linux";
      hostname = "YoRNix";
      # configure lib
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [
            "electron-28.2.10"
          ];
        };
      };
    in
    {
      nixosConfigurations.YoRNix = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit hostname;
          inherit inputs;
          inherit system;
        };
        modules = [ 
          nixos-hardware.nixosModules.framework-13-7040-amd
          ./configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.hyprland.nixosModules.default
          ./display-manager.nix
          ./git.nix
        ];
      };
      homeConfigurations = {
        "_2b@YoRNix" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          inherit hostname;
          inherit system;
          inherit inputs;
          modules = [
            ./home.nix
          ];
        };
      };
    };
}
