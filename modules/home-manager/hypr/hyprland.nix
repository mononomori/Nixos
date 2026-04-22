{
  config,
  pkgs,
  lib,
  inputs,
  awww,
  ...
}:
{

  home.packages = builtins.attrValues {
    inherit (pkgs)
      hyprshot
      hyprpicker
      hyprcursor
      ;
  };

  wayland.windowManager.hyprland = {
    package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    enable = true;
    systemd.enable = false;

    extraConfig = ''



      # # # # # # #
      # Monitors  #
      # # # # # # #

      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor = eDP-1, 2880x1920@120, 0x0, 2.0
      # monitor = DP-4, 2560x1440@59.95, -540x-1440, 1.0
      # monitor = , preferred, auto, 1, mirror, eDP-1

      exec-once = hyprctl setcursor Bibata-Modern-Classic 16

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more

      # Execute your favorite apps at launch

      #### hypridle
      exec-once = systemctl --user enable --now hypridle.service
      exec-once = systemctl --user enable --now sway-audio-idle-inhibit.service
      exec-once = uwsm-app -- dunst


      exec-once = systemctl --user enable --now waybar.service

      exec-once = systemctl --user enable --now hyprpaper.service
      exec-once = uwsm-app -- blueman-applet

      #### wallpaper
      exec-once = uwsm-app -- awww-daemon 
      exec-once = sleep 2 && uwsm-app -- awww img /etc/nixos/modules/home-manager/hypr/wallpapers/laindance.png

      # Source a file (multi-file configs)
      # source = ~/.config/hypr/myColors.conf

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
              disable_while_typing = false
              drag_lock = 0

          }

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }

      misc {
        middle_click_paste = false
      }



      general {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          gaps_in = 3,3,3,3
          gaps_out = 8,3,3,3
          border_size = 2
          col.active_border = rgb(ce7688)
          col.inactive_border = rgb(ba6a7b)
          layout = dwindle
          resize_on_border = true
          no_focus_fallback = false
      }

      decoration {
        rounding = 6
        rounding_power = 4.0
        active_opacity = 1.0
        inactive_opacity = 0.8
        fullscreen_opacity = 1.0
        dim_inactive = true
        dim_strength = 0.3
        dim_special = 0.6
        dim_around = 0.6

        shadow {
          enabled = true
          render_power = 4
          sharp = false
          range = 100
          offset = 0, 0
          scale = 1.0
          color = rgba(ce768830)
          color_inactive = rgba(00000000)
        }


        blur {
          enabled = true
          size = 10
          passes = 1
          noise = 0.1
          contrast = 0.5
          brightness = 1.5
          vibrancy = 1.0
          vibrancy_darkness = 1.0
          new_optimizations = true
          ignore_opacity = false
          xray = false
          special = false
          popups_ignorealpha = 0.2
          input_methods = false
          input_methods_ignorealpha = 0.2

        }

      }

      animations {
          enabled = yes

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05

          enabled = true
          bezier = wind, 0.05, 0.9, 0.1, 1.05
          bezier = winIn, 0.1, 1.1, 0.1, 1.05
          bezier = winOut, 0.1, 1.1, 0.1, 1.05
          bezier = liner, 1, 1, 1, 1
          bezier = decel, 0.05, 0.7, 0.1, 1
          bezier = accel, 0.1, 0, 0.8, 0.15
          bezier = smoothOut, 0.5, 0, 0.99, 0.99
          bezier = smoothIn, 0.1, -0.5, 0.1, 1.3
          animation = windows, 1, 6, wind, slide
          animation = windowsIn, 1, 6, winIn, slide
          animation = windowsOut, 1, 3, accel, popin 60%
          # animation = windowsOut, 1, 5, winOut, slide
          animation = windowsMove, 1, 5, wind, slide
          animation = border, 1, 1, liner
          # animation = borderangle, 1, 30, liner, loop
          animation = fade, 1, 3, smoothOut
          animation = fadeSwitch, 1, 3, smoothIn
          animation = fadeShadow, 1, 3, smoothIn
          animation = workspaces, 1, 5, wind
          animation = layersIn, 1, 3, decel, popin 60%
          animation = layersOut, 1, 3, accel, popin 60%
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


      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
      device {
          name = epic-mouse-v1
          sensitivity = -0.5
      }

      $mainMod = SUPER


      bind = $mainMod, T, exec, uwsm-app -- kitty
      bind = $mainMod ALT, T, exec, [float; move 700 850; size 700 100] uwsm-app -- kitty
      bind = $mainMod, C, killactive, 
      bind = $mainMod, M, exit, 
      bind = $mainMod, E, exec, uwsm-app -- kitty --class yazi -e fish -i -c 'y; exec fish'


      bind = $mainMod, F, togglefloating, 
      bind = $mainMod ALT, F, fullscreen 
      bind = $mainMod, R, exec, uwsm-app -- fuzzel --launch-prefix="uwsm-app -- "
      bind = $mainMod, B, exec, pkill waybar || uwsm-app -- waybar
      bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, L, exec, loginctl lock-session


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
      exec-once = uwsm-app -- clipse -listen

      bind = $mainMod, V, exec, uwsm-app -- kitty --class clipse -e fish -c 'clipse'

      # Screenshots
      bind = , print, exec, uwsm-app -- hyprshot --freeze -m output -o  $HOME/Pictures/Screenshots/ -f $(date +'screenshot_%Y-%m-%d-%H%M%S.png')
      bind = SHIFT, print, exec, uwsm-app -- hyprshot --freeze -m output  --clipboard-only
      bind = $mainMod, print, exec, uwsm-app -- hyprshot --freeze -m window -o $HOME/Pictures/Screenshots/ -f $(date +'screenshot_%Y-%m-%d-%H%M%S.png')
      bind = SHIFT $mainMod, print, exec, uwsm-app -- hyprshot --freeze  -m window --clipboard-only
      bind = CTRL, print, exec, uwsm-app -- hyprshot --freeze -m region -o  $HOME/Pictures/Screenshots/ -f $(date +'screenshot_%Y-%m-%d-%H%M%S.png')
      bind = SHIFT CTRL, print, exec, uwsm-app -- hyprshot --freeze -m region --clipboard-only

      # Gestures
      gesture = 4, horizontal, workspace


      #### Windowrules

      # Audio

      windowrule = float on, match:class org.pulseaudio.pavucontrol
      windowrule = size 950 700, match:class org.pulseaudio.pavucontrol
      windowrule = move (monitor_w)-(975) (monitor_h*0.06), match:class org.pulseaudio.pavucontrol

      # Blueman
      windowrule = float on, match:class .blueman-manager-wrapped
      windowrule = size 950 700, match:class .blueman-manager-wrapped
      windowrule = move (monitor_w)-(975) (monitor_h*0.06), match:class .blueman-manager-wrapped

      # Calcurse
      windowrule = float on, match:class calcurse
      windowrule = size 950 700, match:class calcurse
      windowrule = move (monitor_w*0.02) (monitor_h*0.06), match:class calcurse

      # Clipse
      windowrule = float on, match:class clipse
      windowrule = size 700 800, match:class clipse
      windowrule = move (monitor_w*0.02) (monitor_h*0.06), match:class clipse
      windowrule = xray 0, match:class clipse

      # Floating
      windowrule = no_shadow 1, match:float 0

      # Idle-inhibit
      windowrule = idle_inhibit fullscreen, match:class .*

      # Nemo
      windowrule = float on, match:class nemo
      windowrule = size 950 750, match:class nemo
      windowrule = move (monitor_w*0.02) (monitor_h*0.06), match:class nemo
      windowrule = xray 0, match:class nemo

      # Picture-in-Picture
      windowrule = float on, match:title Picture-in-picture
      windowrule = no_anim on, match:title Picture-in-picture
      windowrule = size 480 270, match:title Picture-in-picture
      windowrule = move (monitor_w)-(500) (monitor_h*0.06), match:title Picture-in-picture

      # RuneLite
      windowrule = float on, match:title RuneLite
      windowrule = size 1038 720, match:title RuneLite

      # Steam Settings
      windowrule = float on, match:class steam, match:title negative:Steam

      # xdg-desktop-portal-gtk windows
      windowrule = float on, match:class xdg-desktop-portal-gtk
      windowrule = size 950 750, match:class xdg-desktop-portal-gtk
      windowrule = move (monitor_w*0.02) (monitor_h*0.06), match:class xdg-desktop-portal-gtk
      windowrule = xray 0, match:class xdg-desktop-portal-gtk

      # Yazi
      windowrule = float on, match:class yazi
      windowrule = size 950 750, match:class yazi
      windowrule = move (monitor_w*0.02) (monitor_h*0.06), match:class yazi
      windowrule = xray 0, match:class yazi


      #### Layerrules

      # Launcher
      layerrule = animation popin, match:namespace launcher
      layerrule = blur on, match:namespace launcher
      layerrule = blur on, match:namespace rofi

      # Screenshot
      layerrule = no_anim on, match:namespace hyprpicker
      layerrule = no_anim on, match:namespace selection

      # Waybar
      layerrule = animation slide top, match:namespace waybar
      # layerrule = blur, waybar


    '';
  };

}
