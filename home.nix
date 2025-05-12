{
  home = {
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "code"; # For graphical editors
    };

    stateVersion = "24.11";
  };

  imports = [
    ./modules/home-manager
  ];
}
