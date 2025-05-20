{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "iosevkab-font";
  version = "1.0";
  src = ./.;
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp $src/*.ttf $out/share/fonts/truetype/
  '';
}
