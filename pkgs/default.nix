{
  pkgs,
  lib,
  ...
}: let
  radiosondeSrc = pkgs.fetchFromGitHub {
    owner = "projecthorus";
    repo = "radiosonde_auto_rx";
    rev = "757925effaadf876152c1d42022e03b129c44594";
    hash = "sha256-k6bgOlDL4xDRU1qcH2q5lBERkJDzv5b7RHggPFJ8EwU=";
  };
in
  lib.genAttrs [
    "rs41mod"
    "rs92mod"
  ] (name: pkgs.callPackage ./demod/${name}.nix {inherit radiosondeSrc;})
