{

description = "NixOs flake for my Stellaris laptop";

inputs = {
	nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
	nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
	nixos-hardware.url = "github:NixOS/nixos-hardware/master";
	home-manager = {
		url = "github:nix-community/home-manager/release-23.11";
		inputs.nixpkgs.follows = "nixpkgs";
	};
};

outputs = { self, nixpkgs, nixos-hardware, home-manager, ... }@inputs: {
	nixosConfigurations.stellaris = nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		modules = [
			./configuration.nix
			nixos-hardware.nixosModules.tuxedo-pulse-14-gen3

			home-manager.nixosModules.home-manager {
				home-manager.useGlobalPkgs = true;
				home-manager.useUserPackages = true;
				home-manager.users.viktor = import ./home.nix;
			}
		];
	};
};

}