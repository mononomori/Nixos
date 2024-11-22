{ config, pkgs, inputs, ... }:

{
  
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "_2b";
  home.homeDirectory = "/home/_2b";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

 #### Colors:
 # {"Smoky black":"0B0405","Blush":"CA6E85","China rose":"B56577","China rose 2":"9E5668","Quinacridone magenta":"864958","Wine":"6A3945","Rosy brown":"C69A8E","Rosy brown 2":"C9928D","Khaki":"C1B291","Khaki 2":"ACA082"}


  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };


  #Gtk
  gtk = {
    enable = true;
    font.name = "TeX Gyre Adventor";
    font.size = 10;
    theme = {
      name = "Juno-mirage";
      package = pkgs.juno-theme;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
        gtk-cursor-theme-name=Bibata-Modern-Classic
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
        gtk-cursor-theme-name=Bibata-Modern-Classic
      '';
    };

  };

  #### Hyprland:
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

  #### Kitty:
  programs.kitty = {
    enable = true;
    extraConfig = ''
      font_family Iosevka Term
      font_size 14.0
      bold_font auto
      italic_font auto
      bold_italic_font auto

      bold_text  #CDD6F4
      italic_text #CDD6F4
      bold_italic_text #CDD6F4
     
      background_opacity 0.7

      # The basic colors
      foreground              #CED6F6
      background              #1C1C28
      selection_foreground    #1C1C28
      selection_background    #E9E1D7

      # Cursor colors
      cursor                  #FFB8B8
      cursor_text_color       #1C1C28

      # URL underline color when hovering with mouse
      url_color               #F5B6DC

      # Kitty window border colors
      active_border_color     #A8B9F9
      inactive_border_color   #5C606C
      bell_border_color       #FFD1A8

      # OS Window titlebar colors
      wayland_titlebar_color  #1C1C28
      macos_titlebar_color    #1C1C28

      # Tab bar colors
      active_tab_foreground   #0F0F1B
      active_tab_background   #D7A6F3
      inactive_tab_foreground #CED6F6
      inactive_tab_background #171723
      tab_bar_background      #0F0F1B

      # Colors for marks (marked text in the terminal)
      mark1_foreground #1C1C28
      mark1_background #A8B9F9
      mark2_foreground #1C1C28
      mark2_background #D7A6F3
      mark3_foreground #1C1C28
      mark3_background #71D7EA

      # The 16 terminal colors

      # black
      color0 #3B3D50
      color8 #4C5063

      # red
      color1 #F287A3
      color9 #F287A3

      # green
      color2  #9ED3A3
      color10 #9ED3A3

      # yellow
      color3  #F2D6AF
      color11 #F2D6AF

      # blue
      color4  #81A3F9
      color12 #81A3F9

      # magenta
      color5  #F1B9E3
      color13 #F1B9E3

      # cyan
      color6  #8BD4C5
      color14 #8BD4C5

      # white
      color7  #A8AEC4
      color15 #99A4B8
      
    '';
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = [
        {
          grace = 10;
        }
      ];
      
      background = [
        {
          path = "screenshot";
          blur_passes = 2;
          contras = 1;
          birghtness = 0.5;
          vibrancy = 0.2;
          vibrancy_darkness = 0.2;
        }
      ];
    };
  };


  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/_2b/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
