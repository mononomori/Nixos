{ pkgs }:
# Custom Iosevka font that uses some similar elements to OCR-B Font
pkgs.stdenv.mkDerivation {
  pname = "iosevkab-font";
  version = "1.0";
  src = ./IosevkaB-Fonts;
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp $src/*.ttf $out/share/fonts/truetype/
  '';
}
