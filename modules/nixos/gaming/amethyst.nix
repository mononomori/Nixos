{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

let
  amethyst = pkgs.appimageTools.wrapType2 {
    pname = "amethyst-mod-manager";
    version = "1.2.14";
    src = pkgs.fetchurl {
      url = "https://github.com/ChrisDKN/Amethyst-Mod-Manager/releases/download/v1.2.14/AmethystModManager-1.2.14-x86_64.AppImage";
      hash = "sha256-+ncldQDIraDrnkfRVagf3+K9oODlQdsqki54iiWJ4PI=";
    };
  };
in
{
  environment.systemPackages = [ amethyst ];
}
