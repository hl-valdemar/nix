{
  home = {
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "zed"; # For graphical editors
    };

    stateVersion = "24.11";
  };

  imports = [
    ./modules/home-manager
  ];
}
