{ srcs ? import ./nix/sources.nix
, big-model ? false
}:
let
  enModelSmall = pkgs.fetchzip {
    url = "https://alphacephei.com/kaldi/models/vosk-model-small-en-us-0.15.zip";
    sha256 = "1rl65n2maayggnzi811x6zingkd1ny2z7p0fvcbfaprbz5khz2h8";
  };
  enModelLGraph = pkgs.fetchzip {
    url = "https://alphacephei.com/vosk/models/vosk-model-en-us-0.22-lgraph.zip";
    sha256 = "1dl9sf36mn8l3bcxni4qwrv52hwsfmcm9j08km7iz2vhaiz5wn0r";
  };

  enModel =
    if big-model
    then enModelLGraph
    else enModelSmall;

  pkgs = import srcs.nixpkgs {};

  py-vosk = pkgs.callPackage ./py-vosk { inherit enModelSmall; };

  nerd-drv = pkgs.callPackage ./. {
    python3 = pkgs.python3.withPackages (_: [ py-vosk ]);
  };
in
pkgs.mkShell {
  packages = [ nerd-drv ];
  shellHook = ''
    # Adds a environment variable to the nix-shell for us on the command line when telling nerd-dictation where the model is located.
    export VOSK_MODEL_EN=${enModel}
  '';
}
