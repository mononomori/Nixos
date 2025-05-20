{ pkgs }:

#OCR-F fonts
pkgs.stdenv.mkDerivation {
  pname = "ocr-font";
  version = "1.0";
  src = ./.;
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp $src/*.ttf $out/share/fonts/truetype/
  '';
}
