{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  virtualisation.waydroid.enable = true;
  virtualisation.waydroid.package = pkgs.waydroid-nftables;

  # Enable clipboard sharing
  environment.systemPackages = [ pkgs.wl-clipboard ];

  # Persist these android props into waydroid_base.prop before every container start.
  systemd.services.waydroid-container.serviceConfig.ExecStartPre = lib.mkAfter [
    (pkgs.writeShellScript "waydroid-persist-props" ''
      set -eu
      PROP_FILE=/var/lib/waydroid/waydroid_base.prop
      set_prop() {
        if [ -f "$PROP_FILE" ]; then
          ${pkgs.gnused}/bin/sed -i "/^$1=/d" "$PROP_FILE"
          echo "$1=$2" >> "$PROP_FILE"
        fi
      }
      set_prop persist.waydroid.fake_touch '*'
      set_prop persist.waydroid.width 1280
      set_prop persist.waydroid.height 900
    '')
  ];
}
