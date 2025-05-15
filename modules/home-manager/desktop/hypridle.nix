{ config, pkgs, lib, inputs, ... }:

{
  home.packages = with pkgs; [
    hypridle
    sway-audio-idle-inhibit  # inhibits idle when any audio is playing.
  ];
  services.hypridle = {
    enable = true;
    settings = {
      general = [ 
        {
          lock_cmd = "pgrep hyprlock || hyprlock";       # avoids starting multiple hyprlock instances.
          before_sleep_cmd = "loginctl lock-session";    # lock before suspend.
          after_sleep_cmd = "hyprctl dispatch dpms on";  # to avoid having to press a key twice to turn on the display.
        }
      ];
        # set monitor backlight to minimum when timeout has passed, restore monitor backlight when activity detected.
      listener = [ 
        {
          timeout = 150;
          on-timeout = "brightnessctl -s; curr=$(brightnessctl g); max=$(brightnessctl m); perc=$(( 100 * curr / max )); if [ \"$perc\" -gt 20 ]; then brightnessctl set 20%; fi";
          on-resume = "brightnessctl -r";
        }
        # keyboard backlight when timout has passed, screen on when activity detected.
        { 
          timeout = 150;                               
          on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
          on-resume = "brightnessctl -rd rgb:kbd_backlight";        
        }
        # lock screen when timeout thas passed.
        {
          timeout = 180; 
          on-timeout = "loginctl lock-session";
        }
        # screen off when timeout has passed, screen on when activity detected.
        {
          timeout = 330;                                
          on-timeout = "hyprctl dispatch dpms off";     
          on-resume = "hyprctl dispatch dpms on";       
        }
        {
          timeout = 1800;                                
          on-timeout = "systemctl suspend";              
        }
      ];
    };
  };
}