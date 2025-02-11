{
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
    git = true;
    icons = "always";
    colors = "always";
  };
}
