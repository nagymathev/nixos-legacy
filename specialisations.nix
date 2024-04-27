{ config, lib, pkgs, ... }:

{

specialisation = {
	on-the-go.configuration = {
		system.nixos.tags = [ "on-the-go" ];

		# Enable dGPU offloading, so the machine will use iGPU unless stated otherwise. Essentially I can tell the machine when to drain the batterry dry. (Great for being on the go hence the name)
		hardware.nvidia = {
			prime.offload.enable = lib.mkForce true;
			prime.offload.enableOffloadCmd = lib.mkForce true;
			prime.sync.enable = lib.mkForce false;
		};
	};
};

}