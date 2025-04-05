{ config, pkgs, lib, inputs, ... }:

{

  home.packages = with pkgs; [ 
    mpv 
    yt-dlp # for youtube/streaming support

  ];
  programs.mpv = {
    enable = true;

  package = (
    pkgs.mpv-unwrapped.wrapper {
      scripts = with pkgs.mpvScripts; [
        uosc
        sponsorblock
      ];

      mpv = pkgs.mpv-unwrapped.override {
        waylandSupport = true;
      };
    }
  );

  config = {
    profile = "high-quality";
    ytdl-format = "bestvideo+bestaudio";
    cache-default = 4000000;
  };
};




}