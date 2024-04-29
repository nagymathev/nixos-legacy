{

description = "NixOs flake for my Stellaris laptop";

inputs = {
	#nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
	nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
	nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
	nixos-hardware.url = "github:NixOS/nixos-hardware/master";
	home-manager = {
		url = "github:nix-community/home-manager";
		inputs.nixpkgs.follows = "nixpkgs";
	};
	tuxedo-rs.url = "github:AaronErhardt/tuxedo-rs";
};

outputs = { self, nixpkgs, nixpkgs-unstable, nixos-hardware, home-manager, ... }@inputs:
let
	system = "x86_64-linux";
	pkgs = import nixpkgs {
		inherit system;
		config.allowUnfree = true;
		config.permittedInsecurePackages = [
			"electron-25.9.0"
		];
	};
	pkgs-unstable = import nixpkgs-unstable {
		inherit system;
		config.allowUnfree = true;
		config.permittedInsecurePackages = [
			"electron-25.9.0"
		];
	};
	lib = nixpkgs.lib; 
in {
	nixosConfigurations.stellaris = nixpkgs.lib.nixosSystem {
		inherit system;
		specialArgs = {
			inherit inputs;
			inherit pkgs;
			inherit pkgs-unstable;
		};
		modules = [
			./configuration.nix
			nixos-hardware.nixosModules.tuxedo-pulse-14-gen3

			home-manager.nixosModules.home-manager {
				home-manager.useGlobalPkgs = true;
				home-manager.useUserPackages = true;
				home-manager.users.viktor = import ./home;
			}
		];
	};
};

}