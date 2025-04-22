{
  xdg.configFile = {
    "zellij/themes/gruvbox.kdl" = {
      source = ./zellij/themes/gruvbox.kdl;
    };
  };

  programs.zellij = {
    enable = true;
    enableZshIntegration = false;
    # enableBashIntegration = false;

    settings = {
      # theme = "everforest-dark";
      theme = "vesper";
    };
  };
}
