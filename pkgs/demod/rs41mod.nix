{
  radiosondeSrc,
  stdenv,
}:
stdenv.mkDerivation {
  name = "rs41mod";

  src = "${radiosondeSrc}/demod/mod";

  buildPhase = ''
    make rs41mod
  '';

  installPhase = ''
    mkdir -p $out/bin
    install -Dm744 rs41mod $out/bin
  '';
}
