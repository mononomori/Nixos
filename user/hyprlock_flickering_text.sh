#!/run/current-system/sw/bin/bash

# Predefined alpha values for sporadic transitions (80 frames total)
alphas=(
    "00" "0d" "4d" "80" "4d" "99" "cc" "ff" "b3" "e6"
    "ff" "d9" "ff" "80" "ff" "4d" "cc" "4d" "b3" "26"
    "4d" "00" "0d" "26" "80" "b3" "4d" "e6" "80" "ff"
    "d9" "cc" "ff" "4d" "99" "4d" "b3" "26" "0d" "00"
    "00" "00" "0d" "26" "26" "4d" "4d" "80" "00" "00"
    "00" "0d" "4d" "26" "80" "b3" "d9" "ff" "b3" "e6"
    "ff" "99" "cc" "80" "ff" "4d" "b3" "4d" "80" "26"
)

# Constants
cache_file="/tmp/flicker_random_cache"
cache_duration=2  # Duration in seconds to retain random values
default_color="#d2738a"  # Default color for "Become visible"
inverse_color="#e4c9af"  # Default color for "You are invisible"
flicker_chance=7  # Chance to trigger alpha channel flickering (1 in N)
flip_chance=20  # Chance to flip (1 in X)
flip_min=3  # Minimum frames for flip
flip_max=5  # Maximum frames for flip
pulse_duration=20  # Total frames for one breathing cycle

# Current time
current_time=$(date +%s)

# Retrieve or generate cached random values
if [[ -f "$cache_file" ]]; then
    read last_time random_value_become random_value_you_are < "$cache_file"
    if (( current_time - last_time >= cache_duration )); then
        random_value_become=$(( (RANDOM + current_time) % flicker_chance ))
        random_value_you_are=$(( (RANDOM + current_time + 17) % flicker_chance ))
        echo "$current_time $random_value_become $random_value_you_are" > "$cache_file"
    fi
else
    random_value_become=$(( (RANDOM + current_time) % flicker_chance ))
    random_value_you_are=$(( (RANDOM + current_time + 17) % flicker_chance ))
    echo "$current_time $random_value_become $random_value_you_are" > "$cache_file"
fi

# Calculate frame index
frame=$(( ($(date +%s%3N) / 50) % 80 ))

# Breathing effect using sine wave
pulse_alpha() {
    local frame="$1"
    local duration="$2"
    local angle=$(echo "scale=10; 2 * 3.14159 * $frame / $duration" | bc -l)
    local sine=$(echo "scale=10; (s($angle) + 1) / 2" | bc -l)
    local alpha=$(printf "%02x" $(echo "$sine * 255" | bc -l | awk '{print int($1)}'))
    echo "$alpha"
}

# Modulated alpha channel for breathing effect
modulated_alpha=$(pulse_alpha "$frame" "$pulse_duration")
alpha="${alphas[frame]}"
combined_alpha=$(printf "%02x" $(( 0x$modulated_alpha * 0x$alpha / 255 )))

# Initialize flickering variables for "Become visible"
become_color="$default_color$combined_alpha"
become_text="&#160;&#160;visible"
become_flip_counter=0

# Initialize flickering variables for "You are invisible"
inverse_color_flicker="$inverse_color$combined_alpha"
you_are_text="invisible"
you_are_flip_counter=0

# Flickering logic for "Become visible"
become_output=""
if (( random_value_become == 0 )); then
    if (( frame >= 40 )); then
        become_color="$inverse_color$combined_alpha"
        become_text="invisible"
    fi

    # Introduce random flips during flickering
    if (( RANDOM % flip_chance == 0 )); then
        become_flip_counter=$(( RANDOM % (flip_max - flip_min + 1) + flip_min ))
    fi

    if (( become_flip_counter > 0 )); then
        become_flip_counter=$(( become_flip_counter - 1 ))
        if [[ $become_text == "&#160;&#160;visible" ]]; then
            become_color="$inverse_color$combined_alpha"
            become_text="invisible"
        else
            become_color="$default_color$combined_alpha"
            become_text="&#160;&#160;visible"
        fi
    fi
    become_output="<span foreground='$default_color'>[&#160;Become</span>&#10;<span foreground='$become_color'>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$become_text</span><span foreground='$default_color'>&#160;]</span>"
else
    # Static output
    become_output="<span foreground='$default_color'>[&#160;Become</span>&#10;<span foreground='$default_color'>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;visible</span><span foreground='$default_color'>&#160;]</span>"
fi

# Flickering logic for "You are invisible"
you_are_output=""
if (( random_value_you_are == 0 )); then
    if (( frame <= 40 )); then
        inverse_color_flicker="$default_color$combined_alpha"
        you_are_text="visible"
    fi

    # Introduce random flips during flickering
    if (( RANDOM % flip_chance == 0 )); then
        you_are_flip_counter=$(( RANDOM % (flip_max - flip_min + 1) + flip_min ))
    fi

    if (( you_are_flip_counter > 0 )); then
        you_are_flip_counter=$(( you_are_flip_counter - 1 ))
        if [[ $you_are_text == "invisible" ]]; then
            inverse_color_flicker="$default_color$combined_alpha"
            you_are_text="visible"
        else
            inverse_color_flicker="$inverse_color$combined_alpha"
            you_are_text="invisible"
        fi
    fi
    you_are_output="<span foreground='$inverse_color'>You are </span><span foreground='$inverse_color_flicker'>$you_are_text</span>"
else
    # Static output
    you_are_output="<span foreground='$inverse_color'>You are </span><span foreground='$inverse_color'>invisible</span>"
fi

# Combine outputs
echo "<span font-family='Fira Code'>&#160;$you_are_output&#10;&#10;$become_output</span>"
