{
  stdenvNoCC,
  radiosondeSrc,
  python3Packages,
  demods,
  lib,
}:
stdenvNoCC.mkDerivation {
  pname = "radiosonde-auto-rx";
  version = radiosondeSrc.shortRev;

  src = "${radiosondeSrc}/auto_rx";

  nativeBuildInputs = [python3Packages.wrapPython];
  pythonPath = with python3Packages; [
    dateutil
    numpy
    requests
    semver
    flask
    flask-socketio
  ];

  buildPhase = let
    linkDemod = demod: "ln -s ${lib.getExe demod} $out/${demod.name}";
  in ''
    mkdir -p $out
    cp -r {autorx,auto_rx.py} $out
    ${builtins.concatStringsSep "\n" (map linkDemod (builtins.attrValues demods))}
  '';

  installPhase = ''
    chmod +x $out/auto_rx.py
    wrapPythonProgramsIn "$out" "$pythonPath"
  '';
}
