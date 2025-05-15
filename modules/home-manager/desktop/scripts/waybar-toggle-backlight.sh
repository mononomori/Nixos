#!/run/current-system/sw/bin/bash

CURRENT=$(brightnessctl g)
if [ "$CURRENT" -eq 0 ]; then
    # Restore saved brightness
    brightnessctl -r
else
    # Save current brightness and set to 0
    brightnessctl -s set 0%
fi
