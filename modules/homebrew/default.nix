{
  homebrew = {
    enable = true;

    brews = [
      "mas"
    ];

    casks = [
      "brave-browser"
      "firefox"
      "signal"
      "raycast"
      "docker"
      "sunvox"
      "visual-studio-code"
    ];

    masApps = {
      "Craft" = 1487937127;
      "Perplexity" = 6714467650;
      "Xcode" = 497799835;
    };

    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "valdemar";
    # mutableTaps = false;
  };
}
