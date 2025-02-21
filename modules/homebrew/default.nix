{
  homebrew = {
    enable = true;

    brews = [
      "mas"
    ];
    casks = [
      "brave-browser"
      "signal"
    ];

    masApps = {
      "Craft" = 1487937127;
      "Perplexity" = 6714467650;
      "Messenger" = 1480068668;
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
  };
}
