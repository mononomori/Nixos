{
  pkgs,
  lib,
  ...
}:
# Installs GIMP and applies the PhotoGIMP config overlay (Photoshop-like
# layout/shortcuts) from https://github.com/Diolinux/PhotoGIMP on top of it.
let
  photogimp = pkgs.fetchFromGitHub {
    owner = "Diolinux";
    repo = "PhotoGIMP";
    rev = "a084de2bdbade3e8a4cc2b40b6174e4c2feed64d"; # v3.1
    hash = "sha256-524lsDRmahWXXP9/cfk2ia+7K6xNFTdoYXO8UUsLP/o=";
  };
in
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      gimp3
      ;
  };

  # Copies the fetched PhotoGIMP config tree into ~/.config/GIMP/<version>
  # instead of symlinking it: GIMP rewrites sessionrc/tool-options at
  # runtime, which a read-only nix-store symlink can't support. A marker
  # file makes this one-time only, so later activations don't overwrite
  # whatever GIMP or the user has since changed.
  #
  # GIMP's config dir is versioned (currently "3.0") separately from its
  # package version (gimp3 is 3.2.4 but still uses share/gimp/3.0). If a
  # future gimp3 update or PhotoGIMP release moves that version, the two
  # pinned versions here won't match, so detect that and skip the PhotoGIMP
  # overlay with a warning rather than installing into the wrong directory
  # (gimp3 itself still installs/updates normally either way).
  home.activation.photogimp = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    gimpDataVersion=$(command ls "${pkgs.gimp3}/share/gimp" | head -n1)
    photogimpVersion=$(command ls "${photogimp}/.config/GIMP" | head -n1)

    if [ "$gimpDataVersion" != "$photogimpVersion" ]; then
      echo "photogimp: gimp3 config version ($gimpDataVersion) != pinned PhotoGIMP version ($photogimpVersion), skipping overlay. See https://github.com/Diolinux/PhotoGIMP/releases" >&2
    else
      gimpConfig="$HOME/.config/GIMP/$gimpDataVersion"
      marker="$gimpConfig/.photogimp-installed"
      if [ ! -e "$marker" ]; then
        run mkdir -p "$gimpConfig"
        run cp -a --no-preserve=mode,ownership "${photogimp}/.config/GIMP/$gimpDataVersion/." "$gimpConfig/"
        run chmod -R u+w "$gimpConfig"
        run touch "$marker"
      fi
    fi
  '';
}