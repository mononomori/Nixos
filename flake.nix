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

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, home-manager, nixos-hardware, ... }:
    let
      system = "x86_64-linux";
      overlay-stable = final: prev: {
        stable = import nixpkgs-stable {
          inherit system;
          config = {
            allowUnfree = true;
            permittedInsecurePackages = [
              "electron-25.9.0"
            ];
          };
        }; 
      }; 
    in
    {
      nixosConfigurations.YoRNix = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          inherit system;
          modules = [ 
            ({ config, pkgs, ...}: { nixpkgs.overlays = [ overlay-stable ]; })
            nixos-hardware.nixosModules.framework-13-7040-amd
            ./configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };

    };
}
