{
  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      # SHELL TOOLS
      # eza is a maintained fork of exa
      exa = "eza";
      l = "eza --color-scale all";
      # compatibility fix for latest versions of eza  with zsh-exa
      ls = "eza -l --color-scale all";
      la = "eza -la --color-scale all";
      # use `eza` instead of `tree`
      tree = "eza -T";
      # zoxide
      cd = "z";
      # git
      lg = "lazygit";
    };
  };
}
