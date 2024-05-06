{
  description = "Nixos configuration";

  inputs = {
    # Default to the nixos-unstable branch
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Latest stable branch of nixpkgs, used for version rollback
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";

    # Hardware pkgs
    nixos-hardware.url = "github:NixOs/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, nixos-hardware, ... }@inputs:
    let
      # ---- System Settings ---- #
      system = "x86_64-linux";
      hostname = "YoRNix";
      # configure lib
      lib = nixpkgs.lib; 
      overlay-stable = final: prev: {
        stable = import nixpkgs-stable {
          inherit system;
          config = {
            allowUnfree = true;
            permittedInsecurePackages = [
              "electron-28.2.10"
            ];
          };
        }; 
      }; 
    in
    {
      nixosConfigurations.YoRNix = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit hostname;
            inherit inputs;
          };
          modules = [ 
            ({ config, pkgs, ...}: { nixpkgs.overlays = [ overlay-stable ]; })
            nixos-hardware.nixosModules.framework-13-7040-amd
            ./configuration.nix
            inputs.home-manager.nixosModules.default
            ./display-manager.nix
            ./git.nix
          ];
        };

    };
}
