{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "iosevkaetoile-font";
  version = "1.0";
  src = ./IosevkaEtoile-Fonts;
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp $src/*.ttc $out/share/fonts/truetype/
  '';
}
