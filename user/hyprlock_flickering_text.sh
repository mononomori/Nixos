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
    "80" "4d" "99" "cc" "b3" "e6" "ff" "d9" "4d" "00"
)

# Constants
cache_file="/tmp/flicker_random_cache"
cache_duration=2  # Duration in seconds to retain random values
visible_color="#d2738a"
invisible_color="#e4c9af"
flicker_chance=14  # Chance to trigger alpha channel flickering (1 in N)
flip_chance=20  # Chance to flip text for min-max frames (1 in X)
flip_min=3 
flip_max=5 
pulse_duration=60  # Total frames for one alpha breathing cycle

current_time=$(date +%s)

# Retrieve or generate cached random values
if [[ -f "$cache_file" ]]; then
    read last_time visible_random_value invisible_random_value < "$cache_file"
    if (( current_time - last_time >= cache_duration )); then
        visible_random_value=$(( (RANDOM + current_time) % flicker_chance ))
        invisible_random_value=$(( (RANDOM + current_time + 17) % flicker_chance ))
        echo "$current_time $visible_random_value $invisible_random_value" > "$cache_file"
    fi
else
    visible_random_value=$(( (RANDOM + current_time) % flicker_chance ))
    invisible_random_value=$(( (RANDOM + current_time + 17) % flicker_chance ))
    echo "$current_time $visible_random_value $invisible_random_value" > "$cache_file"
fi

# Calculate frame index
frame=$(( ($(date +%s%3N) / 25) % 80 ))

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
visible_color_flicker="$visible_color$combined_alpha"
visible_text="&#160;&#160;visible"
visible_flip_counter=0

# Initialize flickering variables for "You are invisible"
invisible_color_flicker="$invisible_color$combined_alpha"
invisible_text="invisible"
invisible_flip_counter=0

# Flickering logic for "Become visible"
visible_output=""
if (( visible_random_value == 0 )); then
    if (( frame >= 40 )); then
        visible_color_flicker="$invisible_color$combined_alpha"
        visible_text="invisible"
    fi

    # Introduce random flips during flickering
    if (( RANDOM % flip_chance == 0 )); then
        visible_flip_counter=$(( RANDOM % (flip_max - flip_min + 1) + flip_min ))
    fi

    if (( visible_flip_counter > 0 )); then
        visible_flip_counter=$(( visible_flip_counter - 1 ))
        if [[ $visible_text == "&#160;&#160;visible" ]]; then
            visible_color_flicker="$invisible_color$combined_alpha"
            visible_text="invisible"
        else
            visible_color_flicker="$visible_color$combined_alpha"
            visible_text="&#160;&#160;visible"
        fi
    fi
    visible_output="<span foreground='$visible_color'>[&#160;Become</span>&#10;<span foreground='$visible_color_flicker'>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$visible_text</span><span foreground='$visible_color'>&#160;]</span>"
else
    # Static visible output
    visible_output="<span foreground='$visible_color'>[&#160;Become</span>&#10;<span foreground='$visible_color'>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;visible</span><span foreground='$visible_color'>&#160;]</span>"
fi

# Flickering logic for "You are invisible"
invisible_output=""
if (( invisible_random_value == 0 )); then
    if (( frame <= 40 )); then
        invisible_color_flicker="$visible_color$combined_alpha"
        invisible_text="visible"
    fi

    # Introduce random flips during flickering
    if (( RANDOM % flip_chance == 0 )); then
        invisible_flip_counter=$(( RANDOM % (flip_max - flip_min + 1) + flip_min ))
    fi

    if (( invisible_flip_counter > 0 )); then
        invisible_flip_counter=$(( invisible_flip_counter - 1 ))
        if [[ $invisible_text == "invisible" ]]; then
            invisible_color_flicker="$visible_color$combined_alpha"
            invisible_text="visible"
        else
            invisible_color_flicker="$invisible_color$combined_alpha"
            invisible_text="invisible"
        fi
    fi
    invisible_output="<span foreground='$invisible_color'>You are </span><span foreground='$invisible_color_flicker'>$invisible_text</span>"
else
    # Static invisible output
    invisible_output="<span foreground='$invisible_color'>You are </span><span foreground='$invisible_color'>invisible</span>"
fi

# Combined output
echo "<span font-family='Fira Code'>&#160;$invisible_output&#10;&#10;$visible_output</span>"
