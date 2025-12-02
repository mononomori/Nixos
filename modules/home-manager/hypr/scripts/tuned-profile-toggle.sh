#!/run/current-system/sw/bin/bash


AC_ON=$(cat /sys/class/power_supply/AC*/online 2>/dev/null)

# Get current power profile name
current=$(tuned-adm active | sed 's/.*: //')

if [ "$AC_ON" = "1" ]; then
    # --- AC profiles ---
    if [ "$current" = "throughput-performance" ]; then
        new="powersave"
    elif [ "$current" = "powersave" ]; then
        new="balanced"
    else
        new="throughput-performance"
    fi
else
    # --- Battery profiles ---
    if [ "$current" = "balanced-battery" ]; then
        new="balanced"
    elif [ "$current" = "balanced" ]; then
        new="powersave"
    else
        new="balanced-battery"
    fi
fi

tuned-adm profile "$new"
notify-send "Power Profile" "Switched to: $new"

# Output the new profile name so Waybar can display it if needed
echo "$new"
