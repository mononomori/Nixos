{ config, pkgs, lib, inputs, ... }:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        anchor = "center";
        width = 50;
        lines = 20;
      };
      border = {
        width = 4;
      };
      colors = {
        background = "00000020";
        text = "e4c9afff";
        prompt = "d2738aff";
        placeholder = "838ba7ff";
        input = "e4c9afff";
        match = "d2738aff";
        selection = "d2738a50";
        selection-text = "f0dbdfff";
        selection-match = "d2738aff";
        counter = "838ba7ff";
        border = "d2738aff";
      };
    };
  };
}