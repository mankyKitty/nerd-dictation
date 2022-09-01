let
  inherit (import ./. {}) pkgs py-vosk enModel nerd-dict;
in
with pkgs; mkShell {
  packages = [
    (python3.withPackages (_: [ py-vosk ]))
    ydotool
    wtype
    nerd-dict
  ];
  shellHook = ''
    export VOSK_MODEL_EN=${enModel}
  '';
}
