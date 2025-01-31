{ config, lib, pkgs, ... }: let

nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload"
	''
	export __NV_PRIME_RENDER_OFFLOAD=1
	export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
	export __GLX_VENDOR_LIBRARY_NAME=nvidia
	export __VK_LAYER_NV_optimus=NVIDIA_only
	exec "$@"
	'';

in {

environment.systemPackages = with pkgs; [
	nvidia-offload
];

# Enable OpenGL
hardware.opengl = {
	enable = true;
	driSupport = true;
	driSupport32Bit = true;
};

# Load nvidia driver for Xorg and Wayland
services.xserver.videoDrivers = ["nvidia"];
hardware.opengl.extraPackages = with pkgs; [
	vaapiVdpau # may solve wayland not working
];

hardware.nvidia = {

	# Modesetting is required.
	modesetting.enable = true;

	# Nvidia power management. Experimental, and can cause sleep/suspend to fail.
	# Enable this if you have graphical corruption issues or application crashes after waking
	# up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
	# of just the bare essentials.
	powerManagement.enable = true;

	# Fine-grained power management. Turns off GPU when not in use.
	# Experimental and only works on modern Nvidia GPUs (Turing or newer).
	powerManagement.finegrained = true;

	# Use the NVidia open source kernel module (not to be confused with the
	# independent third-party "nouveau" open source driver).
	# Support is limited to the Turing and later architectures. Full list of 
	# supported GPUs is at: 
	# https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
	# Only available from driver 515.43.04+
	# Currently alpha-quality/buggy, so false is currently the recommended setting.
	open = false;

	# Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
	nvidiaSettings = true;

	# Optionally, you may need to select the appropriate driver version for your specific GPU.
	package = config.boot.kernelPackages.nvidiaPackages.stable;
};

hardware.nvidia.prime = {

	# Using sync mode by default as the laptop is docked most of the time. There is a specialisation available for on-the-go setting using offloading. This mode greatly increases performance and reduces screen tearing, at the expense of higher power consumpsion sinthe the dGPU will not go to sleep comletely unless called for, as in the case in Offload Mode.
	#sync.enable = true;

	# Offloading by defautl because I don't want everything to run on the GPU as it does with sync mode.
	offload = {
		enable = true;
		enableOffloadCmd = true;
	};

	# The Bus IDs of my Stellaris laptop
	amdgpuBusId = "PCI:6:0:0";
	nvidiaBusId = "PCI:1:0:0";
};
}