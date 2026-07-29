{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withRuby = true;
    withPython3 = true;
    plugins = with pkgs.vimPlugins; [
      vim-tidal
    ];
  };
}
