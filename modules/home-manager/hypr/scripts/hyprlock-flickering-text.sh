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

# Pre-computed sine wave for breathing effect (61 frames, 0x00 to 0xff)
# Formula: alpha = ((sin(2π * frame / 61) + 1) / 2) * 255
sine_wave=(
    "80" "8d" "9a" "a7" "b4" "c0" "ca" "d4" "dd" "e6"
    "ed" "f3" "f8" "fc" "fe" "ff" "ff" "fe" "fc" "f8"
    "f3" "ed" "e6" "dd" "d4" "ca" "c0" "b4" "a7" "9a"
    "8d" "80" "72" "65" "58" "4b" "3f" "35" "2b" "22"
    "19" "12" "0c" "07" "03" "01" "00" "00" "01" "03"
    "07" "0c" "12" "19" "22" "2b" "35" "3f" "4b" "58"
    "72"
)

cache_file="/tmp/flicker_random_cache"
cache_duration=2  # Duration in seconds to retain random values
visible_color="#d2738a"
invisible_color="#e4c9af"
flicker_chance=13  # Chance to trigger alpha channel flickering (1 in N)
flip_chance=17  # Chance to flip text for min-max frames (1 in N)
flip_min=3 
flip_max=7 

now_ms=$(date +%s%3N)
current_time=$(( now_ms / 1000 ))

# Retrieve or generate cached random values
cached_time=-1
if [[ -f "$cache_file" ]]; then
    read -r cached_time visible_random_value invisible_random_value < "$cache_file"
fi
if (( current_time - cached_time >= cache_duration )); then
    visible_random_value=$(( (RANDOM + current_time) % flicker_chance ))
    invisible_random_value=$(( (RANDOM + current_time + 17) % flicker_chance ))
    echo "$current_time $visible_random_value $invisible_random_value" > "$cache_file"
fi

# Calculate frame indices
# 80 and 61 are coprime, meaning their cycles only align every 4880 frames (122 seconds at 25ms per frame)
frame=$(( (now_ms / 25) % 80 ))
sine_frame=$(( (now_ms / 25) % 61 ))

# Combine predefined alpha with sine wave modulation
alpha="${alphas[frame]}"
modulated_alpha="${sine_wave[sine_frame]}"
combined_alpha=$(printf "%02x" $(( 0x$modulated_alpha * 0x$alpha / 255 )))

# Initialize output variables
visible_output=""
invisible_output=""

# Flickering logic for "Become visible"
if (( visible_random_value == 0 )); then
    visible_color_flicker="$visible_color$combined_alpha"
    visible_text="&#160;&#160;visible"

    if (( frame >= 50 && frame <= 70 )); then
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
            visible_text="invisible"
            visible_color_flicker="$invisible_color$combined_alpha"
        else
            visible_text="&#160;&#160;visible"
            visible_color_flicker="$visible_color$combined_alpha"
        fi
    fi

    visible_output="<span foreground='$visible_color'>[&#160;Become</span>&#10;<span foreground='$visible_color_flicker'>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$visible_text</span><span foreground='$visible_color'>&#160;]</span>"
else
    visible_output="<span foreground='$visible_color'>[&#160;Become</span>&#10;<span foreground='$visible_color'>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;visible</span><span foreground='$visible_color'>&#160;]</span>"
fi

# Flickering logic for "You are invisible"
if (( invisible_random_value == 0 )); then
    invisible_color_flicker="$invisible_color$combined_alpha"
    invisible_text="invisible"

    if (( frame >= 50 && frame <= 70 )); then
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
            invisible_text="visible"
            invisible_color_flicker="$visible_color$combined_alpha"
        else
            invisible_text="invisible"
            invisible_color_flicker="$invisible_color$combined_alpha"
        fi
    fi

    invisible_output="<span foreground='$invisible_color'>You are </span><span foreground='$invisible_color_flicker'>$invisible_text</span>"
else
    invisible_output="<span foreground='$invisible_color'>You are </span><span foreground='$invisible_color'>invisible</span>"
fi

# Combined output
echo "<span font-family='Fira Code'>&#160;$invisible_output&#10;&#10;$visible_output</span>"