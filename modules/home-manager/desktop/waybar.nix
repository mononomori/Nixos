{ config, pkgs, lib, inputs, ... }: 
{
  # Add your nerd font package as needed for icons:
  # fonts.packages = with pkgs.nerd-fonts; [ jetbrains-mono ];
  

  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "graphical-session.target"; # or another target if you want
  };
    settings = [
      # --- Main Top Bar ---
      {
        layer = "top";
        position = "top";
        height = 32;
        width = 1440;
        "margin-right" = 10;
        "margin-left" = 10;
        "margin-top" = 0;
        "margin-bottom" = 0;
        "fixed-center" = true;
        exclusive = true;
        passthrough = false;
        reload_style_on_change = true;

        # Module arrays
        "modules-left" = [
          "clock#time"
          "clock"
          "custom/weather"
          "memory"
          "cpu"
          "temperature"
        ];
        "modules-center" = [
          "hyprland/workspaces"
          "custom/nixos"
          "hyprland/workspaces#right"
        ];
        "modules-right" = [
          "wireplumber"
          "battery"
          "backlight"
          "network"
          "idle_inhibitor"
          "tray"
        ];

        # All the modules from modules.json:
        "custom/nixos" = {
          format = "󱄅";
          tooltip = true;
          "tooltip-format" = "present day... present time...";
          "on-click" = "power-menu --waybar";
        };

        "hyprland/workspaces" = {
          "on-click" = "activate";
          format = "<span size='larger'>{icon}</span>";
          "format-icons" = {
            "1" = "l";
            "2" = "o";
            "3" = "v";
            "4" = "e";
          };
          "icon-size" = 14;
          "sorty-by-number" = true;
          "persistent-workspaces" = { "*" = [ 1 2 3 4 ]; };
          "ignore-workspaces" = [ "5" "6" "7" "8" ];
        };

        "hyprland/workspaces#right" = {
          "on-click" = "activate";
          format = "<span size='larger'>{icon}</span>";
          "format-icons" = {
            "5" = "l";
            "6" = "a";
            "7" = "i";
            "8" = "n";
          };
          "icon-size" = 14;
          "sorty-by-number" = true;
          "persistent-workspaces" = { "*" = [ 5 6 7 8 ]; };
          "ignore-workspaces" = [ "1" "2" "3" "4" ];
        };

        memory = {
          format = " {}%";
          tooltip = true;
        };

        cpu = {
          format = " {usage}%";
          tooltip = true;
        };

        temperature = {
          interval = 10;
          "hwmon-path" = "/sys/devices/platform/coretemp.0/hwmon/hwmon4/temp1_input";
          "critical-threshold" = 100;
          "format-critical" = " {temperatureC}";
          format = " {temperatureC}°";
        };

        "custom/weather" = {
          format = "{}°";
          tooltip = true;
          interval = 3600;
          exec = "wttrbar --nerd";
          "return-type" = "json";
        };

        clock = {
          format = "{:%d.%m}";
          "tooltip-format" = "present day...";
          "on-click" = "kitty --class calcurse -e calcurse";
        };

        "clock#time" = {
          format = "{:%H:%M}";
          "tooltip-format" = "present time...";
          "format-alt" = "{:%I:%M %p}";
        };

        wireplumber = {
          format = "{icon} {volume}%";
          "format-muted" = "󰝟";
          "format-icons" = {
            default = [ "󰕿" "󰖀" "󰕾" ];
          };
          "on-click" = "pavucontrol";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          "on-click" =
            "current=$(powerprofilesctl get); if [ \"$current\" = 'performance' ]; then new='power-saver'; elif [ \"$current\" = 'power-saver' ]; then new='balanced'; else new='performance'; fi; powerprofilesctl set \"$new\" && notify-send \"Power Profile\" \"Switched to: $new\"";
          format = "{icon} {capacity}%";
          "format-full" = "{icon} {capacity}%";
          "format-charging" = "󰂄 {capacity}%";
          "format-plugged" = "󰂄 {capacity}%";
          "format-icons" = [
            "󰂃"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
        };

        backlight = {
          format = "{icon} {percent}%";
          tooltip = true;
          "format-icons" = [
            "󰛩"
            "󱩎"
            "󱩏"
            "󱩐"
            "󱩑"
            "󱩒"
            "󱩓"
            "󱩔"
            "󱩕"
            "󱩖"
            "󰛨"
          ];
          "on-scroll-up" = "brightnessctl set 1%+";
          "on-scroll-down" = "brightnessctl set 1%-";
          "smooth-scrolling-threshold" = "2400";
          "tooltip-format" = "Brightness {percent}%";
          "on-click" = "/etc/nixos/modules/home-manager/desktop/scripts/waybar-toggle-backlight.sh";
        };

        network = {
          "format-wifi" = "{icon} {signalStrength}%";
          "format-icons" = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          "format-ethernet" = "󰈀";
          "format-disconnected" = "󰤫";
          "tooltip-format-wifi" = "{essid} ({signalStrength}%) 󰘊";
          "tooltip-format-ethernet" = "{ifname} {ipaddr}/{cidr}";
          "tooltip-format-disconnected" = "Disconnected";
          "on-click" = "networkmanager_dmenu --anchor top-right --width 40 --x-margin 200 --lines 15";
        };

        idle_inhibitor = {
          format = "{icon}";
          "format-icons" = {
            activated = "󰈈";
            deactivated = "󰛐";
          };
        };

        tray = {
          "show-passive-items" = false;
          spacing = 12;
          "icon-size" = 13;
        };
      }
    ];

    style = ''
      * {
          min-height: 0;
      }
      window#waybar {
          color: #d2738a;
          background-color: #000000;
      }
      tooltip * {
          color: #d2738a;
      }
      .modules-left,
      .modules-center,
      .modules-right {
          font-size: 14px;
      }
      #custom-nixos {
          padding-left: 15px;
          padding-right: 15px;
          font-size: 24px;
          color: #d2738a;
      }
      #custom-nixos:hover {
          transition: color .2s ease;
          color: #e4c9af;
      }
      #workspaces button {
          color: #e4c9af;
          border: 2px solid transparent;
          font-size: 14px;
          padding-right: 12px;
          padding-left: 12px;
      }
      #workspaces button.empty {
          color: #d2738a;
      }
      #workspaces button.active {
          animation: fade-in-out 1.2s infinite alternate cubic-bezier(0.37, 0, 0.63, 1);
      }
      @keyframes fade-in-out {
          from { opacity: 1; }
          to { opacity: 0; }
      }
      #workspaces button:hover {
          color: transparent;
          transition: color .3s ease;
          text-shadow: 0 0 2px #e4c9af;
      }
      #workspaces button.active:hover {
          text-shadow: 0 0 2px #e4c9af;
      }
      #workspaces button.empty:hover {
          text-shadow: 0 0 2px #d2738a;
      }
      #wireplumber,
      #backlight,
      #idle_inhibitor {
          color: #d2738a;
          padding-left: 12px;
          padding-right: 12px;
          border: 2px solid #d2738a;
          border-right-color: transparent;
          border-bottom-left-radius: 7px;
          border-top-left-radius: 7px;
      }
      #battery,
      #network,
      #tray {
          color: #e4c9af;
          padding-left: 12px;
          padding-right: 12px;
          border: 2px solid #e4c9af;
          border-right-color: transparent;
          border-bottom-left-radius: 7px;
          border-top-left-radius: 7px;
      }
      #temperature,
      #memory,
      #clock
       {
          color: #d2738a;
          padding-left: 12px;
          padding-right: 12px;
          border: 2px solid #d2738a;
          border-left-color: transparent;
          border-bottom-right-radius: 7px;
          border-top-right-radius: 7px;
      }
      #custom-weather,
      #cpu,
      #clock.time {
          color: #e4c9af;
          padding-left: 12px;
          padding-right: 12px;
          border: 2px solid #e4c9af;
          border-left-color: transparent;
          border-bottom-right-radius: 7px;
          border-top-right-radius: 7px;
      }
    '';
  };
}
