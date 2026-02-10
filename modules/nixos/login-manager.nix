{ config, pkgs, lib, inputs, ... }:

# Enable tuigreet display manager
let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
in
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
      command = "${tuigreet} --time --time-format '%a, %d %b %Y • %T' --greeting  '[Become \n              Visible]' --asterisks --theme 'border=lightred;title=gray;greet=gray;text=gray;prompt=lightred;time=gray;action=gray;button=gray;container=black;input=gray' --cmd 'uwsm start -eD Hyprland hyprland.desktop'";
      user = "greeter";
      };
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  environment.pathsToLink = [ "/share/wayland-sessions" ];
}
