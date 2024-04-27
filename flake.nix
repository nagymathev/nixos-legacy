{

description = "NixOs flake for my Stellaris laptop";

inputs = {
	nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
	nixos-hardware.url = "github:NixOS/nixos-hardware/master";
};

outputs = { self, nixpkgs, nixos-hardware, ... }@inputs: {
	nixosConfigurations.stellaris = nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		modules = [
			./configuration.nix
			nixos-hardware.nixosModules.tuxedo-pulse-14-gen3
		];
	};
};

}