{
  pkgs,
  lib,
  inputs,
  ...
} @ args: let
  radiosondeSrc = inputs.radiosonde-auto-rx;

  inherit (import ./demod.nix (args // {inherit radiosondeSrc;})) mkDemod;

  demods = let
    mkDemods = basedir: list: lib.genAttrs list (name: mkDemod {inherit name basedir;});
  in
    (mkDemods "demod/mod" [
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
    // (mkDemods "weathex" ["weathex301d"])
    // (mkDemods "mk2a" ["mk2a1680mod"])
    // (mkDemods "imet" ["imet4iq"])
    // (mkDemods "utils" ["fsk_demod"])
    // (mkDemods "scan" ["dft_detect"]);
in
  demods
  // rec {
    radiosonde-auto-rx = pkgs.callPackage ./autorx.nix {inherit radiosondeSrc demods;};
    default = radiosonde-auto-rx;
  }
