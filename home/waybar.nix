{ config, ... }:

{

programs.waybar = {
	enable = true;
	settings = {
		mainBar = {
			layer = "top";
			position = "top";
			height = 30;
			output = [
				"eDP-2"
			];
			modules-left = [ "hyprland/workspaces" "hyprland/mode" "wlr/taskbar" ];
			modules-center = [ "hyprland/window" "custom/hello-from-waybar" ];
			modules-right = [ "mpd" "custom/mymodule#with-css-id" "temperature" "time" ];

			"sway/workspaces" = {
				disable-scroll = true;
				all-outputs = true;
			};
			"custom/hello-from-waybar" = {
				format = "hello {}";
				max-length = 40;
				interval = "once";
				exec = pkgs.writeShellScript "hello-from-waybar" ''
				echo "from within waybar"
				'';
			};
		};
	};
};

}