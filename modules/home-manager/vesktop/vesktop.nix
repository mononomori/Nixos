{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  programs.vesktop = {
    enable = true;

    # tailscale/tailscale#10396: Chromium's WebRTC ICE gathering gets confused
    # by the tailscale0 tunnel interface and hangs at "DTLS connecting".
    # Run vesktop in a firejail net namespace bridged to wlan0 only, so it
    # never sees tailscale0.
    package = pkgs.vesktop.overrideAttrs (oldAttrs: {
      postFixup = ''
        ${oldAttrs.postFixup or ""}
        mv $out/bin/vesktop $out/bin/.vesktop-unjailed
        cat > $out/bin/vesktop <<EOF
        #!/bin/sh
        exec firejail --net=wlan0 --noprofile $out/bin/.vesktop-unjailed "\$@"
        EOF
        chmod +x $out/bin/vesktop
      '';
    });

    settings = {
      arRPC = true;
      clickTrayToShowHide = true;
      discordBranch = "stable";
      hardwareAcceleration = true;
      hardwareVideoAcceleration = true;
      minimizeToTray = true;
      tray = true;
    };

    vencord.themes.laintop = pkgs.writeText "laintop.css" (builtins.readFile ./laintop.css);

    vencord.settings = {
      useQuickCss = false;
      enabledThemes = [ "laintop.css" ];
    };
  };
}
