{
  homebrew = {
    enable = true;

    taps = [
      # "homebrew/cask-fonts"
      "homebrew-zathura/zathura"
    ];

    brews = [
      "mas"
      "mpv"
      "unar"
      "yt-dlp"
      "glfw"
      "pkg-config"
      "eye-d3"
      "zathura"
      "zathura-pdf-poppler"
    ];

    casks = [
      "brave-browser"
      "firefox"
      "signal"
      "raycast"
      "docker"
      "sunvox"
      "visual-studio-code"
      "wine-stable"
      "iina" # GOATed media player
      "keycastr"
      "zed"
    ];

    masApps = {
      "Craft" = 1487937127;
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
