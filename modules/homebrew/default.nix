{
  homebrew = {
    enable = true;
    brews = ["mas"];
    casks = ["brave-browser"];
    masApps = {
      "Craft" = 1487937127;
      "Perplexity" = 6714467650;
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
