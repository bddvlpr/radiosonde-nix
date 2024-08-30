{
  pkgs,
  lib,
  ...
} @ args: let
  radiosondeSrc = pkgs.fetchFromGitHub {
    owner = "projecthorus";
    repo = "radiosonde_auto_rx";
    rev = "757925effaadf876152c1d42022e03b129c44594";
    hash = "sha256-k6bgOlDL4xDRU1qcH2q5lBERkJDzv5b7RHggPFJ8EwU=";
  };

  inherit (import ./demod.nix (args // {inherit radiosondeSrc;})) mkDemod;

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
  // (mkDemods "scan" ["dft_detect"])
