{...}: {
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;

    dotDir = ".config/zsh";

    history = {
      path = "$HOME/.cache/zsh/history";
      size = 10000;
    };

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

    oh-my-zsh = {
      enable = true;
      theme = "pmcgee";
    };

    # This is using a rec (recursive) expression to set and access XDG_BIN_HOME within the expression
    # For more on rec expressions see https://nix.dev/tutorials/first-steps/nix-language#recursive-attribute-set-rec
    # sessionVariables = {
    #   # CTRL+E(dit) : fuzzy search for files to open in $EDITOR
    #   # FZF_FINDER_EDITOR_BINDKEY = "^e";
    #   # ALT+R(ead) : fuzzy search for files to open with default pager
    #   # FZF_FINDER_PAGER_BINDKEY = "^[r";
    #   # make fzf finder plugin search hidden files too
    #   # FZF_FINDER_FD_OPTS = "--hidden -t f";
    #   # print path before cd'ing for zoxide
    #   _ZO_ECHO = 0;
    #   # Prevent zinit from trying to copy the man page (which currently fails)
    #   ZINIT_NO_MANPAGE = 1;
    # };

    # completionInit = ''
    #   autoload -Uz compinit
    #   compinit
    #   zinit cdreplay -q
    # '';

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
