#!/usr/bin/env bash

hyprpaper &
/run/wrappers/bin/polkit-agent-helper-1 &
waybar &
dunst &
nm-applet --indicator &