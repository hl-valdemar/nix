{
  # xdg.configFile."yazi/yazi.toml".source = ./yazi/yazi.toml;

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

    # flavors = {
    #   sunset = ./yazi/flavors/sunset;
    # };

    # theme = {
    #   flavor = {
    #     use = "sunset";
    #   };
    # };
  };
}
