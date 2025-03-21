{inputs, ...}: {
  homebrew = {
    enable = true;

    brews = [
      "mas"
    ];
    casks = [
      "brave-browser"
      "signal"
      "raycast"
      "docker"
    ];

    masApps = {
      "Craft" = 1487937127;
      "Perplexity" = 6714467650;
      "Messenger" = 1480068668;
    };

    onActivation = {
      cleanup = "zap";
      # autoUpdate = true; # disabled as it can conflict with nix’s declarative management
      upgrade = true;
    };
  };

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "valdemar";
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
    };
    mutableTaps = false;
  };
}
