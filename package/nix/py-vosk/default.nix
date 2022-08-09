{ stdenv
, enModelSmall
, python3
}:
python3.pkgs.buildPythonPackage rec {
  pname = "vosk";
  version = "0.3.43";
  VOSK_MODEL_PATH = "${enModelSmall}";
  format = "wheel";
  # This package name is weird and can't be found using the simple route.
  # vosk-0.3.43-py3-none-manylinux_2_12_x86_64.manylinux2010_x86_64.whl
  src = python3.pkgs.fetchPypi {
    inherit pname version;
    format = "wheel";
    python = "py3";
    dist = "py3";
    abi = "none";
    platform = "manylinux_2_12_x86_64.manylinux2010_x86_64";
    sha256 = "0v22acm96r3g3ymnka7f6zbsy0xbjriirpnncyj26w4i5m9df299";
  };
  propagatedBuildInputs = with python3.pkgs; [
    requests
    srt
    tqdm
    websockets
  ] ++ [
    stdenv.cc.cc.lib
  ];
}
