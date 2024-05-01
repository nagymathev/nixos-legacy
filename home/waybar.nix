{ config, pkgs, ... }:

{

xdg.configFile."waybar/style.css".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/home/waybar.css";

programs.waybar = {
	enable = true;
	# style = ./waybar.css;
	settings = {
		mainBar = {
			layer = "top";
			position = "top";
			height = 30;
			output = [
				"eDP-2"
			];
			modules-left = [ "hyprland/workspaces" "sway/mode" "wlr/taskbar" ];
			modules-center = [ "hyprland/window" "custom/hello-from-waybar" ];
			modules-right = [ "mpd" "custom/mymodule#with-css-id" "battery" "temperature" "clock" ];

			"hyprland/workspaces" = {
				disable-scroll = true;
				all-outputs = true;
			};
			"custom/hello-from-waybar" = {
				format = "hello {}";
				max-length = 40;
				interval = "once";
				exec = pkgs.writeShellScript "hello-from-waybar" ''
				echo "I am a shell script"
				'';
			};
		};
	};
};

}