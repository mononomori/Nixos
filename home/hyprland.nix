{ config, pkgs, lib, inputs, ... }:


{
  wayland.windowManager.hyprland = {
    enable = true;


    extraConfig = ''
  
    

      # # # # # # #
      # Monitors  #
      # # # # # # #

      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor=,2880x1920@120,auto,2.0

      exec-once = hyprctl setcursor Bibata-Modern-Classic 16

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more

      # Execute your favorite apps at launch
      exec-once = waybar
      exec-once = hyprpaper
      exec-once = nm-applet
      exec-once = blueman-applet

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
          col.active_border = rgba(e5b9c6ff) rgba(c293a3ff) 45deg
          col.inactive_border = 0xff382D2E
          no_border_on_floating = false
          layout = dwindle
      }

      decoration {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          rounding = 4
          active_opacity = 1.0
          inactive_opacity = 0.50
          blur:enabled = true
          blur:size = 6
          blur:passes = 3
          blur:new_optimizations = true
          blur:xray = true
          blur:ignore_opacity = true
          drop_shadow = false
          shadow_ignore_window = true
          shadow_offset = 1 2
          shadow_render_power = 5
          shadow_range = 10
          col.shadow = 0x66404040
          blurls = waybar
          blurls = lockscreen
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

      # Example windowrule v1
      # windowrule = float, ^(kitty)$
      # Example windowrule v2
      #  windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      # windowrulev2=opacity 0.1 override 0.1 override,class:^(kitty)$
      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      $mainMod = SUPER

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = $mainMod, T, exec, kitty
      bind = $mainMod, C, killactive, 
      bind = $mainMod, M, exit, 
      bind = $mainMod, E, exec, dolphin
      bind = $mainMod, F, togglefloating, 
      bind = $mainMod, R, exec, rofi -show drun -show-icons
      bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, J, togglesplit, # dwindle

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

      # Screenshots
      bind = , print, exec, hyprshot -m output -o $HOME/Pictures/Screenshots/ -f $(date +'screenshot_%Y-%m-%d-%H%M%S.png')
      bind = SHIFT, print, exec, hyprshot -m output --clipboard-only
      bind = $mainMod, print, exec, hyprshot -m window -o $HOME/Pictures/Screenshots/ -f $(date +'screenshot_%Y-%m-%d-%H%M%S.png')
      bind = SHIFT $mainMod, print, exec, hyprshot -m window --clipboard-only
      bind = CTRL, print, exec, hyprshot -m region -o $HOME/Pictures/Screenshots/ -f $(date +'screenshot_%Y-%m-%d-%H%M%S.png')
      bind = SHIFT CTRL, print, exec, hyprshot -m region --clipboard-only


      # Kitty
      windowrulev2 = opacity 0.9 0.8, class:(kitty)

    '';
  };
}