{ config, pkgs, lib, inputs, ... }:

{
  home.packages = with pkgs; [
    waybar
    (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    )
  ];

  programs.waybar.enable = true;

  programs.waybar.settings = {
    layer = "top"; # Waybar at top layer
    mode = "top";
    margin-top = 2;
    margin-left = 4;
    margin-right = 4;
    margin-bottom = -1;
    position = "top"; # Waybar position (top|bottom|left|right)
    height = 10; # Waybar height (to be removed for auto height)
    width= 1280; # Waybar width
     spacing = 6; # Gaps between modules (4px)
    # Choose the order of the modules
    reload_style_on_change = true;
    modules-left= [
        "custom/nixos"
        "hyprland/workspaces"
    ];
    modules-center = [
        "hyprland/window"
    ];
    modules-right = [
        "idle_inhibitor"
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        "temperature"
        "power-profiles-daemon"
        "battery"
        "backlight"
        "clock"
        "custom/power-menu"
    ];

        "custom/nixos" = {
        "format" = "󱄅";
        "tooltip" = true;
        "tooltip-format" = "present day... present time..."
    };


    "hyprland/workspaces" = {
        "disable-scroll" = true;
        "all-outputs" = true;
        "warp-on-scroll" = false;
        "format" = "{name}";
        "format-icons" = {
            "urgent" = "";
            "active" = "";
            "default" = ""
        }
    };
    "idle_inhibitor" = {
        "format" = "{icon}";
        "format-icons" = {
            "activated" = "";
            "deactivated" = ""
        }
    };
    "pulseaudio" = {
        "format" = "{icon}  {volume}%";
        "format-bluetooth" = "{icon} {volume}%  {format_source}";
        "format-bluetooth-muted" = " {icon} {format_source}";
        "format-muted" = "";
        "format-source" = " {volume}%";
        "format-source-muted" = "";
        "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = ["" "" " "];
        };
        "on-click" = "pavucontrol"
    };
"network" = {
    "format-wifi" = "   {essid} ({signalStrength}%)";
    "format-ethernet" = "{ipaddr}/{cidr} ";
    "tooltip-format" = "{ifname} via {gwaddr} ";
    "format-linked" = "{ifname} (No IP) ";
    "format-disconnected" = "Disconnected ⚠";
    "on-click" = "networkmanager_dmenu --anchor top-right --width 40 --x-margin 200 --lines 15"

};
    "cpu" = {
        "format" = "  {usage}%";
        "tooltip" = true
    };
    "memory" = {
        "format" = "  {}%";
	"tooltip" = true
    };
    "temperature" = {
        "interval" = 10;
        "hwmon-path" = "/sys/devices/platform/coretemp.0/hwmon/hwmon4/temp1_input";
        "critical-threshold" = 100;
        "format-critical" = " {temperatureC}";
        "format" = " {temperatureC}°C"
    };
    "power-profiles-daemon" = {
        "format" = "{icon}";
        "tooltip-format" = "Power profile = {profile}nDriver = {driver}";
        "tooltip" = true;
        "format-icons" = {
            "default" = "";
            "performance" = "";
            "balanced" = "";
            "power-saver" = ""
        }
    };
    "battery" = {
        "states" = {
            "warning" = 30;
            "critical" = 15
        };
        "format" = "{icon}   {capacity}%";
        "format-full" = "{icon}  {capacity}%";
        "format-charging" = "  {capacity}%";
        "format-plugged" = "  {capacity}%";
        "format-alt" = "{time}  {icon}";
        "format-icons" = ["" "" "" "" ""];
    };
    "backlight" = {
        "format" = "{icon}  {percent}%";
        "tooltip" = true;
        "format-alt" = "<small>{percent}%</small>";
        "format-icons" = ["󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩕" "󱩖" "󰛨"];
        "on-scroll-up" = "brightnessctl set 1%+";
        "on-scroll-down" = "brightnessctl set 1%-";
        "smooth-scrolling-threshold" = "2400";
        "tooltip-format" = "Brightness {percent}%"
      };

    "clock" = {
        "format" = "{ =%H =%M | %e %B} ";
        "tooltip-format" = "<big>{ =%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        "format-alt" = "{ =%Y-%m-%d}"
    };

    "custom/power-menu" = {
    "format" = "";
    "tooltip" = true;
    "on-click" = "power-menu --waybar"
    }
    
  };
}