{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "iosevkaaile-font";
  version = "1.0";
  src = ./.;
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp $src/*.ttc $out/share/fonts/truetype/
  '';
}
