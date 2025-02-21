{ config, pkgs, lib, inputs, swww, ... }:


{
  home.packages = with pkgs; [
    hyprshot
    hyprpicker
    hyprcursor
    waybar
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;


    extraConfig = ''
  
    

      # # # # # # #
      # Monitors  #
      # # # # # # #

      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor=,2880x1920@120,auto,2.0

      exec-once = hyprctl setcursor Bibata-Modern-Classic 16

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more

      # Execute your favorite apps at launch

      #### hypridle
      exec-once = hypridle
      exec-once = sway-audio-idle-inhibit
      windowrulev2 = idleinhibit fullscreen, class:.*

      exec-once = waybar
      exec-once = hyprpaper
      exec-once = nm-applet
      exec-once = blueman-applet

      #### wallpaper
      exec-once = swww-daemon 
      exec-once = sleep 2 && swww img /etc/nixos/user/lainwallpaper1.jpg

      # Source a file (multi-file configs)
      # source = ~/.config/hypr/myColors.conf

      # Some default env vars.

      env = QT_QPA_PLATFORM,wayland


      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
          kb_layout = us
          kb_variant =
          kb_model =
          kb_options = caps:super
          kb_rules =

          follow_mouse = 1

          touchpad {
              natural_scroll = no
          }

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }



      general {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          gaps_in = 5
          gaps_out = 5
          border_size = 2
          col.active_border = rgba(d2738aff) rgba(ba667aff) 45deg
          col.inactive_border = rgba(d2738a99)
          no_border_on_floating = false
          layout = dwindle
          resize_on_border = true
      }

      decoration {

        shadow {
        enabled = true
        ignore_window = true
        render_power = 5
        range = 10
        offset = 1 2
        color = 0x66404040
        }
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          rounding = 6
          active_opacity = 1.0
          inactive_opacity = 0.9
          fullscreen_opacity = 1.0
          blur:enabled = true
          blur:size = 7
          blur:passes = 2
          blur:new_optimizations = true
          blur:xray = false
          layerrule = blur, waybar
          layerrule = blur, rofi
          layerrule = blur, launcher

      }

      animations {
          enabled = yes

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05

          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
          animation = layers, 1, 3, default, popin 80%
      }

      dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = false # you probably want this
      }

      master {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_status = slave
      }

      gestures {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = true
      }

      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
      device {
          name = epic-mouse-v1
          sensitivity = -0.5
      }

      $mainMod = SUPER


      bind = $mainMod, T, exec, kitty
      bind = $mainMod, C, killactive, 
      bind = $mainMod, M, exit, 
      bind = $mainMod, E, exec, dolphin
      bind = $mainMod, F, togglefloating, 
      bind = $mainMod ALT, F, fullscreen 
      bind = $mainMod, R, exec, fuzzel
      bind = $mainMod, B, exec, pkill waybar || waybar

      bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, J, togglesplit, # dwindle
      bind = $mainMod, L, exec, hyprlock

      # Change focused window
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      # Move focused window
      bind = $mainMod SHIFT, left, movewindow, l
      bind = $mainMod SHIFT, right, movewindow, r
      bind = $mainMod SHIFT, up, movewindow, u
      bind = $mainMod SHIFT, down, movewindow, d

      # Resize focused window
      binde = $mainMod ALT, left, resizeactive, -20 0
      binde = $mainMod ALT, right, resizeactive, 20 0
      binde = $mainMod ALT, up, resizeactive, 0 -20
      binde = $mainMod ALT, down, resizeactive, 0 20

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # Enable function keys

      binde =, xf86audioraisevolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
      binde =, xf86audiolowervolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-
      bind =, xf86audiomute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      binde =, xf86monbrightnessup, exec, brightnessctl set 10%+
      binde =, xf86monbrightnessdown, exec, brightnessctl set 10%-

      # Clipboard
      exec-once = clipse -listen
      windowrulev2 = float,class:(clipse)
      windowrulev2 = size 700 800,class:(clipse)
      windowrulev2 = move 20 70,class:(clipse)
      windowrulev2 = xray 0,class:(clipse)
      bind = $mainMod, V, exec, kitty --class clipse -e fish -c 'clipse'
      layerrule = animation popin, launcher
      layerrule = animation slide top, waybar


      # Screenshots
      bind = , print, exec, hyprshot --freeze -m output -o  $HOME/Pictures/Screenshots/ -f $(date +'screenshot_%Y-%m-%d-%H%M%S.png')
      bind = SHIFT, print, exec, hyprshot --freeze -m output  --clipboard-only
      bind = $mainMod, print, exec, hyprshot --freeze -m window -o $HOME/Pictures/Screenshots/ -f $(date +'screenshot_%Y-%m-%d-%H%M%S.png')
      bind = SHIFT $mainMod, print, exec, hyprshot --freeze  -m window --clipboard-only
      bind = CTRL, print, exec, hyprshot --freeze -m region -o  $HOME/Pictures/Screenshots/ -f $(date +'screenshot_%Y-%m-%d-%H%M%S.png')
      bind = SHIFT CTRL, print, exec, hyprshot --freeze -m region --clipboard-only

      layerrule = noanim, hyprpicker
      layerrule = noanim, selection

    '';
  };
}