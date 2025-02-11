{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    # make fzf search hidden files too
    defaultCommand = "ag --hidden --ignore .git -g '' ";
  };
}
