{ config, pkgs, lib, inputs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      vim-tidal
    ];
  };
}