{
  radiosondeSrc,
  stdenv,
}:
stdenv.mkDerivation {
  name = "rs92mod";

  src = "${radiosondeSrc}/demod/mod";

  buildPhase = ''
    make rs92mod
  '';

  installPhase = ''
    mkdir -p $out/bin
    install -Dm744 rs92mod $out/bin
  '';
}
