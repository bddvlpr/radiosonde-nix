{
  pkgs,
  lib,
  inputs,
  ...
}: let
  radiosondeSrc = inputs.radiosonde-auto-rx;

  mkDemod = {
    name,
    basedir,
    ...
  } @ args:
    pkgs.stdenv.mkDerivation (args
      // {
        src = "${radiosondeSrc}/${basedir}";

        buildPhase = ''
          make ${name}
        '';

        installPhase = ''
          mkdir -p $out/bin
          install -Dm744 ${name} $out/bin
        '';

        meta.mainProgram = name;
      });

  demods = let
    mkDemodsGroup = basedir: list: lib.genAttrs list (name: mkDemod {inherit name basedir;});
  in
    (mkDemodsGroup "demod/mod" [
      "rs41mod"
      "dfm09mod"
      "m10mod"
      "m20mod"
      "rs92mod"
      "lms6Xmod"
      "meisei100mod"
      "imet54mod"
      "mp3h1mod"
      "mts01mod"
      "iq_dec"
    ])
    // (mkDemodsGroup "weathex" ["weathex301d"])
    // (mkDemodsGroup "mk2a" ["mk2a1680mod"])
    // (mkDemodsGroup "imet" ["imet4iq"])
    // (mkDemodsGroup "utils" ["fsk_demod"])
    // (mkDemodsGroup "scan" ["dft_detect"]);
in
  demods
  // rec {
    radiosonde-auto-rx = pkgs.callPackage ./radiosonde-auto-rx.nix {inherit radiosondeSrc demods;};
    default = radiosonde-auto-rx;
  }
