{ config, lib, pkgs, pkgs-unstable, inputs, ... }:

{

imports = [
	./hyprland.nix
	./waybar.nix
];

home.username = "viktor";
home.homeDirectory = "/home/viktor";

# lib.meta = {
# 	configPath = "/home/viktor/nixos";
# 	mkMutableSymlink = path: config.lib.file.mkOutOfStoreSymlink
# 		(config.lib.meta.configPath + lib.strings.removePrefix (toString inputs.self) (toString path));
# };

# link the configuration file in current directory to the specified location in home directory
# home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

# link all files in `./scripts` to `~/.config/i3/scripts`
# home.file.".config/i3/scripts" = {
#   source = ./scripts;
#   recursive = true;   # link recursively
#   executable = true;  # make all files executable
# };

# encode the file content in nix configuration file directly
# home.file.".xxx".text = ''
#     xxx
# '';

# set cursor size and dpi for 4k monitor
xresources.properties = {
	"Xcursor.size" = 36;
	"Xft.dpi" = 144;
};

home.sessionVariables.NIXOS_OZONE_WL = "1";

# Packages that should be installed to the user profile.
home.packages = with pkgs; [

	obsidian
	megasync
	libreoffice
	vlc
	bitwarden-desktop

	firefox
	vivaldi
	thunderbird

	steam
	protonup-qt
	heroic
	discord
	anki-bin

	wofi
	hyprpaper
	swww
	# grim
	# slurp
	# wl-clipboard
	grimblast

	# Commented out because I have not managed to find an automated solution yet.
	#ciscoPacketTracer8 

	neofetch
	just

	# archives
	zip
	xz
	unzip
	p7zip

	# utils
	ripgrep # recursively searches directories for a regex pattern
	jq # A lightweight and flexible command-line JSON processor
	yq-go # yaml processor https://github.com/mikefarah/yq
	eza # A modern replacement for ‘ls’
	fzf # A command-line fuzzy finder

	# networking tools
	mtr # A network diagnostic tool
	iperf3
	dnsutils  # `dig` + `nslookup`
	ldns # replacement of `dig`, it provide the command `drill`
	aria2 # A lightweight multi-protocol & multi-source command-line download utility
	socat # replacement of openbsd-netcat
	nmap # A utility for network discovery and security auditing
	ipcalc  # it is a calculator for the IPv4/v6 addresses

	# misc
	cowsay
	file
	which
	tree
	gnused
	gnutar
	gawk
	zstd
	gnupg

	# nix related
	#
	# it provides the command `nom` works just like `nix`
	# with more details log output
	nix-output-monitor

	# productivity
	hugo # static site generator
	glow # markdown previewer in terminal

	btop  # replacement of htop/nmon
	iotop # io monitoring
	iftop # network monitoring

	# system call monitoring
	strace # system call monitoring
	ltrace # library call monitoring
	lsof # list open files

	# system tools
	sysstat
	lm_sensors # for `sensors` command
	ethtool
	pciutils # lspci
	usbutils # lsusb
];

catppuccin.flavour = "macchiato";

# basic configuration of git, please change to your own
programs.git = {
	enable = true;
	userName = "nagymathev";
	userEmail = "nagymathev@gmail.com";
};

# starship - an customizable prompt for any shell
programs.starship = {
	enable = true;
	enableZshIntegration = true;
	settings = {
		add_newline = false;
		line_break.disabled = true;
		time = {
			disabled = false;
			format = "[$time]($style)";
		};
		format = ''
[╭─$fill──┤$time├──$fill─╮](bold green)
[├╢](bold green)$directory$nix_shell$git_branch$git_status
[╰─❯](bold green)'';
		fill = {
			symbol = "─";
			style = "bold green";
		};
	};
};

# alacritty - a cross-platform, GPU-accelerated terminal emulator
programs.alacritty = {
	enable = true;
	settings = {
		env.TERM = "xterm-256color";
		font = {
			size = 9;
			normal.family = "Fira Code Nerd Font Mono";
		};
		scrolling.multiplier = 5;
		selection.save_to_clipboard = true;
		window.dimensions.columns = 120;
		window.dimensions.lines = 35;

	};
};

programs.zsh = {
	enable = true;
	enableCompletion = true;
	autosuggestion.enable = true;
	shellAliases = {
	};
};

services.dunst = {
	enable = true;
};

programs.vscode = {
	enable = true;
	userSettings = {
		"editor.detectIndentation" = false;
		"editor.tabSize" = 8;
		"editor.insertSpaces" = false;
		"editor.indentSize" = "tabSize";
		"editor.wordWrap" = "wordWrapColumn";

		#"nix.formatterPath" = "";
	};
	extensions = [
		#pkgs.vscode-extensions.jnoortheen.nix-ide
		pkgs.vscode-extensions.bbenoist.nix
	];
};

# This value determines the home Manager release that your
# configuration is compatible with. This helps avoid breakage
# when a new home Manager release introduces backwards
# incompatible changes.
#
# You can update home Manager without changing this value. See
# the home Manager release notes for a list of state version
# changes in each release.
home.stateVersion = "23.11";

# Let home Manager install and manage itself.
programs.home-manager.enable = true;

}
