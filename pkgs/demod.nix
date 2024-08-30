{
  pkgs,
  radiosondeSrc,
  ...
}: {
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
      });
}
