{pkgs, ...}: {
  xdg.configFile."zed/themes/ferra.json" = {
    source = ./zed/themes/ferra.json;
  };

  home.packages = with pkgs; [
    # Formatters
    nil
    black
    ruff
  ];

  # I can't figure out a good way to configure Zed through Nix, as Zed in many cases requires writable config files...
  programs.zed-editor = {
    enable = true;
  };

  # programs.zed-editor = {
  #   enable = true;
  #
  #   extensions = [
  #     "gruvbox-material"
  #     "nix"
  #     "zig"
  #     "svelte"
  #     "toml"
  #   ];
  #
  #   userSettings = {
  #     vim_mode = true;
  #
  #     theme = {
  #       mode = "system";
  #       light = "Gruvbox Light";
  #       dark = "Ferra";
  #     };
  #
  #     assistant = {
  #       enabled = true;
  #       default_model = {
  #         provider = "zed.dev";
  #         model = "claude-3-5-sonnet-latest";
  #       };
  #     };
  #   };
  #
  #   userKeymaps = [
  #     {
  #       context = "Editor && vim_mode == normal";
  #       bindings = {
  #         "g r" = "editor::Rename";
  #       };
  #     }
  #     {
  #       context = "ProjectPanel && not_editing";
  #       bindings = {
  #         a = "project_panel::NewFile";
  #         r = "project_panel::Rename";
  #         d = "project_panel::Delete";
  #       };
  #     }
  #   ];
  # };
}
