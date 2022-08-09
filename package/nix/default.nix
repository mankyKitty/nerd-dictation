{ stdenv
, lib
, xdotool
, python3
}:
python3.pkgs.buildPythonApplication rec {
  pname = "nerd-dictation";
  version = "20220605";
  format = "other";
  src = ./../../.;

  phases = "installPhase";

  # Not entirely sure why I had to do this manually...
  makeWrapperArgs = [
    "--prefix PATH ':' ${xdotool}/bin"
    "--prefix PYTHONPATH ':' ${python3}/${python3.sitePackages}/"
    "--prefix LD_LIBRARY_PATH ':' ${lib.makeLibraryPath [stdenv.cc.cc.lib]}"
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src/nerd-dictation $out/bin/nerd-dictation
    wrapPythonProgramsIn $out/bin $PYTHONPATH
  '';
}
