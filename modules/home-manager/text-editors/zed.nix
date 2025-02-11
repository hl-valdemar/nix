{...}: {
  xdg.configFile."zed/themes/ferra.json" = {
    source = ./zed/themes/ferra.json;
  };

  programs.zed-editor = {
    enable = true;

    extensions = [
      "gruvbox-material"
      "nix"
      "zig"
      "svelte"
      "toml"
    ];

    userSettings = {
      vim_mode = true;

      theme = {
        mode = "system";
        light = "Gruvbox Light";
        dark = "Ferra";
      };

      assistant = {
        enabled = true;
        default_model = {
          provider = "zed.dev";
          model = "claude-3-5-sonnet-latest";
        };
      };
    };

    userKeymaps = [
      {
        context = "Editor && vim_mode == normal";
        bindings = {
          "g r" = "editor::Rename";
        };
      }
      {
        context = "ProjectPanel && not_editing";
        bindings = {
          a = "project_panel::NewFile";
          r = "project_panel::Rename";
          d = "project_panel::Delete";
        };
      }
    ];
  };
}
#
#     features = {
#       copilot = false;
#       inline_completion_provider = "none";
#     };
#
#     language_models = {
#       anthropic = {
#         available_models = [
#           {
#             name = "claude-3-5-sonnet-20241022";
#             display_name = "Claude 3.5 Sonnet (New)";
#             #max_tokens = 128000;
#             #max_output_tokens = 2560;
#             #cache_configuration = {
#             #  max_cache_anchors = 10;
#             #  min_total_token = 10000;
#             #  should_speculate = false;
#             #};
#           }
#         ];
#       };
#     };
#
#     assistant = {
#       enabled = true;
#       default_model = {
#         provider = "anthropic";
#         model = "claude-3-5-sonnet-20241022";
#       };
#       version = "2";
#       button = true;
#       default_width = 480;
#       dock = "right";
#     };
#
#     soft_wrap = "editor_width";
#     relative_line_numbers = true;
#     # wrap_guides = [90];
#   };
#
# };
# }

