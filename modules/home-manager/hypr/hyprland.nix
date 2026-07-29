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

    # Since Hyprland 0.55, hyprlang is deprecated in favor of Lua.
    # See https://wiki.hypr.land/Configuring/Start/
    configType = "lua";

    extraConfig = ''

      -- # # # # # # #
      -- # Monitors  #
      -- # # # # # # #

      -- See https://wiki.hypr.land/Configuring/Basics/Monitors/
      hl.monitor({ output = "eDP-1", mode = "2880x1920@120", position = "0x0", scale = 2.0 })
      -- hl.monitor({ output = "DP-4", mode = "2560x1440@59.95", position = "-540x-1440", scale = 1.0 })
      -- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto", mirror = "eDP-1" })

      -- See https://wiki.hypr.land/Configuring/Basics/Autostart/

      -- Execute your favorite apps at launch
      hl.on("hyprland.start", function()
        hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 16")

        ---- hypridle
        hl.exec_cmd("systemctl --user enable --now hypridle.service")
        hl.exec_cmd("systemctl --user enable --now sway-audio-idle-inhibit.service")
        hl.exec_cmd("uwsm-app -- dunst")

        hl.exec_cmd("systemctl --user enable --now waybar.service")

        hl.exec_cmd("systemctl --user enable --now hyprpaper.service")
        hl.exec_cmd("uwsm-app -- blueman-applet")

        ---- wallpaper
        hl.exec_cmd("uwsm-app -- awww-daemon")
        hl.timer(function()
          hl.exec_cmd("uwsm-app -- awww img /etc/nixos/modules/home-manager/hypr/wallpapers/laindance.png")
        end, { timeout = 2000, type = "oneshot" })

        -- Clipboard
        hl.exec_cmd("uwsm-app -- clipse -listen")
      end)

      -- Source a file (multi-file configs)
      -- require("myColors")

      -- For all categories, see https://wiki.hypr.land/Configuring/Basics/Variables/
      hl.config({
        input = {
          kb_layout = "us",
          kb_variant = "",
          kb_model = "",
          kb_options = "caps:super",
          kb_rules = "",

          follow_mouse = 1,

          touchpad = {
            natural_scroll = false,
            disable_while_typing = false,
            drag_lock = 0,
          },

          sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
        },

        misc = {
          middle_click_paste = false,
        },

        general = {
          -- See https://wiki.hypr.land/Configuring/Basics/Variables/ for more
          gaps_in = 3,
          gaps_out = { top = 8, right = 3, bottom = 3, left = 3 },
          border_size = 2,
          col = {
            active_border = "rgb(ce7688)",
            inactive_border = "rgb(ba6a7b)",
          },
          layout = "dwindle",
          resize_on_border = true,
          no_focus_fallback = false,
        },

        decoration = {
          rounding = 6,
          rounding_power = 4.0,
          active_opacity = 1.0,
          inactive_opacity = 0.8,
          fullscreen_opacity = 1.0,
          dim_inactive = true,
          dim_strength = 0.3,
          dim_special = 0.6,
          dim_around = 0.6,

          shadow = {
            enabled = true,
            render_power = 4,
            sharp = false,
            range = 50,
            offset = { 0, 0 },
            scale = 1,
            color = "rgba(ce768830)",
            color_inactive = "rgba(00000000)",
          },

          blur = {
            enabled = true,
            size = 10,
            passes = 1,
            noise = 0.1,
            contrast = 0.5,
            brightness = 1.5,
            vibrancy = 1.0,
            vibrancy_darkness = 1.0,
            new_optimizations = true,
            ignore_opacity = false,
            xray = false,
            special = false,
            popups_ignorealpha = 0.2,
            input_methods = false,
            input_methods_ignorealpha = 0.2,
          },
        },

        animations = {
          enabled = true,
        },

        dwindle = {
          -- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
          -- NOTE: the `pseudotile` master switch was removed upstream in 0.55; the
          -- `pseudo` dispatcher (bound to mainMod + P below) still works per-window.
          preserve_split = false, -- you probably want this
        },

        master = {
          -- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
          new_status = "slave",
        },
      })

      -- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
      hl.curve("wind",      { type = "bezier", points = { {0.05, 0.9},  {0.1, 1.05} } })
      hl.curve("winIn",     { type = "bezier", points = { {0.1, 1.1},   {0.1, 1.05} } })
      hl.curve("winOut",    { type = "bezier", points = { {0.1, 1.1},   {0.1, 1.05} } })
      hl.curve("liner",     { type = "bezier", points = { {1, 1},       {1, 1}      } })
      hl.curve("decel",     { type = "bezier", points = { {0.05, 0.7},  {0.1, 1}    } })
      hl.curve("accel",     { type = "bezier", points = { {0.1, 0},     {0.8, 0.15} } })
      hl.curve("smoothOut", { type = "bezier", points = { {0.5, 0},     {0.99, 0.99} } })
      hl.curve("smoothIn",  { type = "bezier", points = { {0.1, -0.5},  {0.1, 1.3}  } })

      hl.animation({ leaf = "windows",     enabled = true, speed = 6, bezier = "wind",   style = "slide" })
      hl.animation({ leaf = "windowsIn",   enabled = true, speed = 6, bezier = "winIn",  style = "slide" })
      hl.animation({ leaf = "windowsOut",  enabled = true, speed = 3, bezier = "accel",  style = "popin 60%" })
      -- hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "winOut", style = "slide" })
      hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "wind",   style = "slide" })
      hl.animation({ leaf = "border",      enabled = true, speed = 1, bezier = "liner" })
      -- hl.animation({ leaf = "borderangle", enabled = true, speed = 30, bezier = "liner", style = "loop" })
      hl.animation({ leaf = "fade",        enabled = true, speed = 3, bezier = "smoothOut" })
      hl.animation({ leaf = "fadeSwitch",  enabled = true, speed = 3, bezier = "smoothIn" })
      hl.animation({ leaf = "fadeShadow",  enabled = true, speed = 3, bezier = "smoothIn" })
      hl.animation({ leaf = "workspaces",  enabled = true, speed = 5, bezier = "wind" })
      hl.animation({ leaf = "layersIn",    enabled = true, speed = 3, bezier = "decel",  style = "popin 60%" })
      hl.animation({ leaf = "layersOut",   enabled = true, speed = 3, bezier = "accel",  style = "popin 60%" })

      -- Example per-device config
      -- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
      hl.device({
        name = "epic-mouse-v1",
        sensitivity = -0.5,
      })

      local mainMod = "SUPER"


      hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("uwsm-app -- kitty"))
      hl.bind(mainMod .. " + ALT + T", hl.dsp.exec_cmd("uwsm-app -- kitty", { float = true, move = "700 850", size = "700 100" }))
      hl.bind(mainMod .. " + C", hl.dsp.window.close())
      hl.bind(mainMod .. " + M", hl.dsp.exit())
      hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("uwsm-app -- kitty --class yazi -e fish -i -c 'y; exec fish'"))


      hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
      hl.bind(mainMod .. " + ALT + F", hl.dsp.window.fullscreen())
      hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("uwsm-app -- fuzzel --launch-prefix=\"uwsm-app -- \""))
      hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("pkill waybar || uwsm-app -- waybar"))
      hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle
      hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("loginctl lock-session"))


      -- Focus / move / resize windows in a direction
      local directions = {
        left  = { x = -20, y = 0 },
        right = { x = 20,  y = 0 },
        up    = { x = 0,   y = -20 },
        down  = { x = 0,   y = 20 },
      }
      for dir, delta in pairs(directions) do
        hl.bind(mainMod .. " + " .. dir, hl.dsp.focus({ direction = dir }))
        hl.bind(mainMod .. " + SHIFT + " .. dir, hl.dsp.window.move({ direction = dir }))
        hl.bind(mainMod .. " + ALT + " .. dir, hl.dsp.window.resize({ x = delta.x, y = delta.y, relative = true }), { repeating = true })
      end

      -- Switch workspaces with mainMod + [0-9]
      -- Move active window to a workspace with mainMod + SHIFT + [0-9]
      for i = 1, 10 do
        local key = i % 10 -- 10 maps to key 0
        hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
        hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
      end

      -- Scroll through existing workspaces with mainMod + scroll
      hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
      hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

      -- Move/resize windows with mainMod + LMB/RMB and dragging
      hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
      hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

      -- Enable function keys

      hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
      hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
      hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
      hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set 10%+"), { repeating = true })
      hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"), { repeating = true })

      -- Clipboard
      hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("uwsm-app -- kitty --class clipse -e fish -c 'clipse'"))

      -- Screenshots: each mode (output/window/region) gets a plain "print" bind
      -- that saves to a file, and a SHIFT+ variant that copies to clipboard instead.
      local function screenshotCmd(mode, clipboardOnly)
        local cmd = "uwsm-app -- hyprshot --freeze -m " .. mode
        if clipboardOnly then
          return cmd .. " --clipboard-only"
        end
        return cmd .. " -o $HOME/Pictures/Screenshots/ -f $(date +'screenshot_%Y-%m-%d-%H%M%S.png')"
      end

      local screenshotModes = {
        { mods = "",       mode = "output" },
        { mods = mainMod,  mode = "window" },
        { mods = "CTRL",   mode = "region" },
      }

      for _, s in ipairs(screenshotModes) do
        local saveKey = s.mods == "" and "print" or (s.mods .. " + print")
        local clipKey = s.mods == "" and "SHIFT + print" or ("SHIFT + " .. s.mods .. " + print")
        hl.bind(saveKey, hl.dsp.exec_cmd(screenshotCmd(s.mode, false)))
        hl.bind(clipKey, hl.dsp.exec_cmd(screenshotCmd(s.mode, true)))
      end

      -- Gestures
      hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })


      ---- Windowrules ----

      -- Shared shape for "float this app at a fixed size/position" rules
      local function floatRule(opts)
        hl.window_rule({
          name = opts.name,
          match = opts.match,
          float = true,
          size = opts.size,
          move = opts.move,
          xray = opts.xray,
          no_anim = opts.no_anim,
        })
      end

      -- Audio
      floatRule({
        name = "pavucontrol",
        match = { class = "org.pulseaudio.pavucontrol" },
        size = "950 700",
        move = "(monitor_w)-(975) (monitor_h*0.06)",
      })

      -- Blueman
      floatRule({
        name = "blueman",
        match = { class = ".blueman-manager-wrapped" },
        size = "950 700",
        move = "(monitor_w)-(975) (monitor_h*0.06)",
      })

      -- Calcurse
      floatRule({
        name = "calcurse",
        match = { class = "calcurse" },
        size = "950 700",
        move = "(monitor_w*0.02) (monitor_h*0.06)",
      })

      -- Clipse
      floatRule({
        name = "clipse",
        match = { class = "clipse" },
        size = "700 800",
        move = "(monitor_w*0.02) (monitor_h*0.06)",
        xray = false,
      })

      -- Floating
      hl.window_rule({
        name = "floating-no-shadow",
        match = { float = false },
        no_shadow = true,
      })

      -- Idle-inhibit
      hl.window_rule({
        name = "idle-inhibit-fullscreen",
        match = { class = ".*" },
        idle_inhibit = "fullscreen",
      })

      -- Nemo
      floatRule({
        name = "nemo",
        match = { class = "nemo" },
        size = "950 750",
        move = "(monitor_w*0.02) (monitor_h*0.06)",
        xray = false,
      })

      -- Picture-in-Picture
      floatRule({
        name = "picture-in-picture",
        match = { title = "Picture-in-picture" },
        no_anim = true,
        size = "480 270",
        move = "(monitor_w)-(500) (monitor_h*0.06)",
      })

      -- RuneLite
      floatRule({
        name = "runelite",
        match = { title = "RuneLite" },
        size = "1038 720",
      })

      -- Steam Settings
      floatRule({
        name = "steam-settings",
        match = { class = "steam", title = "negative:Steam" },
      })

      -- xdg-desktop-portal-gtk windows
      floatRule({
        name = "xdg-desktop-portal-gtk",
        match = { class = "xdg-desktop-portal-gtk" },
        size = "950 750",
        move = "(monitor_w*0.02) (monitor_h*0.06)",
        xray = false,
      })

      -- Yazi
      floatRule({
        name = "yazi",
        match = { class = "yazi" },
        size = "950 750",
        move = "(monitor_w*0.02) (monitor_h*0.06)",
        xray = false,
      })

      ---- Layerrules ----

      -- Launcher
      hl.layer_rule({ name = "launcher", match = { namespace = "launcher" }, animation = "popin", blur = true })
      hl.layer_rule({ name = "rofi", match = { namespace = "rofi" }, blur = true })

      -- Screenshot
      hl.layer_rule({ name = "hyprpicker-no-anim", match = { namespace = "hyprpicker" }, no_anim = true })
      hl.layer_rule({ name = "selection-no-anim", match = { namespace = "selection" }, no_anim = true })

      -- Waybar
      hl.layer_rule({ name = "waybar-anim", match = { namespace = "waybar" }, animation = "slide top" })
      -- hl.layer_rule({ name = "waybar-blur", match = { namespace = "waybar" }, blur = true })


    '';
  };

}
