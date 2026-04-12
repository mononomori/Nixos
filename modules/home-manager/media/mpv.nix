{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      yt-dlp
      ;
  };

  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      uosc
      sponsorblock
    ];
    config = {
      profile = "high-quality";
      ytdl-format = "bestvideo+bestaudio";
      cache-default = 4000000;
      vo = "gpu-next";
      "gpu-api" = "vulkan";
    };
  };
}
