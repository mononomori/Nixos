#!/run/current-system/sw/bin/bash

# This script is a slightly modified version of https://github.com/thnikk/fuzzel-scripts/blob/master/fuzzel-powermenu.sh
# A powermenu fuzzel launcher.

# Default fuzzel location (centered)
FUZZEL_OPTIONS="--anchor center --width 40 --x-margin 200 -l 4"

# Waybar launcher location (top-right)
if [[ "$1" == "--waybar" ]]; then
    FUZZEL_OPTIONS="--anchor top-right --width 40 -l 4"
fi

SELECTION="$(printf "1 - Lock\n2 - Suspend\n3 - Reboot\n4 - Shutdown" | fuzzel --dmenu -p "Power Menu: " $FUZZEL_OPTIONS)"

case $SELECTION in
	*"Lock")
		hyprlock;;
	*"Suspend")
		systemctl suspend;;
	*"Reboot")
		shutdown -r now;;
	*"Shutdown")
		shutdown -h now;;
esac