{ pkgs }:
#OCR-F fonts which are a modified version of OCR-B font that is modernized.
pkgs.stdenv.mkDerivation {
  pname = "ocr-font";
  version = "1.0";
  src = ./OCR-Fonts;
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp $src/*.ttf $out/share/fonts/truetype/
  '';
}
