{
  pkgs,
  ...
}:
# Installs BeeRef (reference image board).
#
# Its exif -> plum-py dependency fails to build on python 3.14: 18 tests
# compare plum's generated source against stored baseline strings that
# predate 3.14. No behaviour test fails, so build plum-py without checks.
let
  beeref = pkgs.beeref.override {
    python3Packages = pkgs.python3Packages.overrideScope (
      _pyFinal: pyPrev: {
        plum-py = pyPrev.plum-py.overridePythonAttrs (_: {
          doCheck = false;
        });
      }
    );
  };
in
{
  home.packages = builtins.attrValues {
    inherit
      beeref
      ;
  };
}
