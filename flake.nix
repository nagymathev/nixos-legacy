{

description = "NixOs flake for my Stellaris laptop";

inputs = {
	nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
};

outputs = { self, nixpkgs, ... }@inputs: {
	nixosConfigurations.stellaris = nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		modules = [
			./configuration.nix
		];
	};
};

}