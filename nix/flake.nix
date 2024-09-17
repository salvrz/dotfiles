{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations.huckleberry = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs system; };
        modules = [
          { networking.hostName = "huckleberry"; }
          ./hosts/huckleberry/hardware-configuration.nix
          ./modules/config/configuration.nix
        ];
      };
      nixosConfigurations.lavender = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs system; };
        modules = [
          { networking.hostName = "lavender"; }
          ./hosts/lavender/hardware-configuration.nix
          ./modules/config/configuration.nix
        ];
      };
    };
}
