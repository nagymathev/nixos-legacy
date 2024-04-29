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

	nvidia-off.configuration = {
		boot.extraModprobeConfig = ''
blacklist nouveau
options nouveau modeset=0
		'';
		
		services.udev.extraRules = ''
# Remove NVIDIA USB xHCI Host Controller devices, if present
ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
# Remove NVIDIA USB Type-C UCSI devices, if present
ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
# Remove NVIDIA Audio devices, if present
ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
# Remove NVIDIA VGA/3D controller devices
ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
		'';
		boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];
	};
};

}