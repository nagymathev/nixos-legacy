{ config, ... }:

{

###############################################################################
#
# TUXEDO SETTINGS
#
###############################################################################

hardware.tuxedo-rs = {
	enable = true;
	tailor-gui.enable = true;
};
# Temporarily until I figure out how to package tuxedo-drivers
hardware.tuxedo-keyboard.enable = true;

boot.kernelParams = [
	"tuxedo_keyboard.mode=0"
	"tuxedo_keyboard.brightness=255"
	"tuxedo_keyboard.color_left=0xff0a0a"
];

}