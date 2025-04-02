{
  pkgs,
  config,
  ...
}: {
  xdg.configFile = {
    "kitty/themes/gruvbox-dark.conf" = {
      source = ./kitty/themes/gruvbox-dark.conf;
    };
    "kitty/themes/espresso.conf" = {
      source = ./kitty/themes/espresso.conf;
    };
    "kitty/themes/everforest.conf" = {
      source = ./kitty/themes/everforest.conf;
    };
    "kitty/themes/vitesse-black.conf" = {
      source = ./kitty/themes/vitesse-black.conf;
    };
    "kitty/themes/vitesse-dark.conf" = {
      source = ./kitty/themes/vitesse-dark.conf;
    };
  };

  programs.kitty = {
    enable = true;

    shellIntegration.enableZshIntegration = true;

    font = {
      name = "Hack Nerd Font";
      size = 14;
    };

    keybindings = {
      "ctrl+equal" = "change_font_size all +1";
      "ctrl+minus" = "change_font_size all -1";
      "ctrl+backspace" = "change_font_size all 0";
    };

    settings = {
      shell = "${pkgs.zsh}/bin/zsh";
      editor = "${pkgs.neovim}/bin/nvim";

      include = "${config.xdg.configHome}/kitty/themes/vitesse-dark.conf";

      disable_ligatures = "always";
      allow_remote_control = true;
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 24;
      macos_option_as_alt = "left";

      background_opacity = 0.95;
      background_blur = 200;
    };
  };
}
