{
  programs.bash = {
    enable = true;

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

    initExtra = ''
      if [[ -f ~/.secrets ]]; then
        source ~/.secrets
      fi
      if [[ -f ~/.profile ]]; then
        source ~/.profile
      fi

      # Vi mode
      bindkey -v
      export KEYTIMEOUT=1

      # Use vim keys in tab complete menu:
      bindkey -M menuselect 'h' vi-backward-char
      bindkey -M menuselect 'k' vi-up-line-or-history
      bindkey -M menuselect 'l' vi-forward-char
      bindkey -M menuselect 'j' vi-down-line-or-history
      bindkey -v '^?' backward-delete-char

      # Use CTRL+D to enter devenv defined shell
      bindkey -s '^S' 'devenv shell\n'

      # Change cursor shape for different vi modes.
      function zle-keymap-select {
        if [[ ''${KEYMAP} == vicmd ]] ||
           [[ $1 = 'block' ]]; then
          echo -ne '\e[1 q'
        elif [[ ''${KEYMAP} == main ]] ||
             [[ ''${KEYMAP} == viins ]] ||
             [[ ''${KEYMAP} = "" ]] ||
             [[ $1 = 'beam' ]]; then
          echo -ne '\e[5 q'
        fi
      }
      zle -N zle-keymap-select
      zle-line-init() {
          zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
          echo -ne "\e[5 q"
      }
      zle -N zle-line-init
      echo -ne '\e[5 q' # Use beam shape cursor on startup.
      preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
    '';
  };
}
