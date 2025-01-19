#!/run/current-system/sw/bin/bash

# This script is a slightly modified version of https://github.com/thnikk/fuzzel-scripts/blob/master/fuzzel-powermenu.sh
# which can be used to launch a dmenu power menu with fuzzel.

SELECTION="$(printf "1 - Lock\n2 - Suspend\n3 - Reboot\n4 - Shutdown" | fuzzel --dmenu -l 4 -p "Power Menu: ")"

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