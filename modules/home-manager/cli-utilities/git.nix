{
  programs.git = {
    enable = true;
    userEmail = "valdemar.lorenzen@gmail.com";
    userName = "hl-valdemar";
    extraConfig = {
      pull.rebase = false; # Merge when branches diverge
      init.defaultBranch = "main";
    };
  };
}
