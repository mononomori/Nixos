{
  description = "Nixos config flake";

  inputs = {
    nixos-hardware.url = "github:NixOs/nixos-hardware/master";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
    
      nixosConfigurations.YoRNix = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [ 
            nixos-hardware.nixosModules.framework-13-7040-amd
            ./configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };

    };
}
