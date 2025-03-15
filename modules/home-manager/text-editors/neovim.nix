{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.neovim = let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    fromGitHub = repo: ref: rev:
      pkgs.vimUtils.buildVimPlugin {
        pname = "${lib.strings.sanitizeDerivationName repo}";
        version = ref;
        src = builtins.fetchGit {
          url = "https://github.com/${repo}.git";
          ref = ref;
          rev = rev;
        };
      };
  in {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      lua-language-server
      nixd
      zls
      gopls
      typescript-language-server
      svelte-language-server
      vscode-langservers-extracted
      pyright
      typstfmt
      marksman
      xclip
      wl-clipboard
      stylua
      ruff
      prettierd
      go
      gofumpt
      golines
      goimports-reviser
      yamlfmt
      alejandra
      taplo
    ];

    plugins = with pkgs.vimPlugins; [
      nvim-ts-context-commentstring
      neodev-nvim
      telescope-fzf-native-nvim
      cmp_luasnip
      cmp-nvim-lsp
      trouble-nvim
      luasnip
      friendly-snippets
      nvim-web-devicons
      vim-nix
      flash-nvim

      {
        plugin = gruvbox-material;
      }
      {
        plugin = everforest;
      }
      {
        plugin = treesj;
        config = toLua "require('treesj').setup()";
      }
      # {
      #   plugin = lsp_lines-nvim;
      #   config = toLuaFile ./neovim/plugin/lsp-lines.lua;
      # }
      {
        plugin = tiny-inline-diagnostic-nvim;
        config = toLuaFile ./neovim/plugins/tiny-inline-diagnostic.lua;
      }
      {
        plugin = autoclose-nvim;
        config = toLuaFile ./neovim/plugins/autoclose.lua;
      }
      {
        plugin = tabout-nvim;
        config = toLuaFile ./neovim/plugins/tabout.lua;
      }
      {
        plugin = conform-nvim;
        config = toLuaFile ./neovim/plugins/conform.lua;
      }
      {
        plugin = nvim-tree-lua;
        config = toLuaFile ./neovim/plugins/nvim-tree.lua;
      }
      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./neovim/plugins/lsp.lua;
      }
      {
        plugin = comment-nvim;
        config = toLuaFile ./neovim/plugins/comment.lua;
      }
      {
        plugin = nvim-cmp;
        config = toLuaFile ./neovim/plugins/cmp.lua;
      }
      {
        plugin = telescope-nvim;
        config = toLuaFile ./neovim/plugins/telescope.lua;
      }
      {
        plugin = lualine-nvim;
        config = toLuaFile ./neovim/plugins/lualine.lua;
      }
      {
        plugin = nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
          p.tree-sitter-toml
          p.tree-sitter-zig
          p.tree-sitter-go
          p.tree-sitter-rust
          p.tree-sitter-typescript
          p.tree-sitter-javascript
          p.tree-sitter-svelte
          p.tree-sitter-yuck
          p.tree-sitter-typst
          p.tree-sitter-markdown
          p.tree-sitter-glsl
          p.tree-sitter-c
          p.tree-sitter-cpp
        ]);
        config = toLuaFile ./neovim/plugins/treesitter.lua;
      }

      {
        plugin = fromGitHub "echasnovski/mini.surround" "main" "aa5e245829dd12d8ff0c96ef11da28681d6049aa";
        config = toLuaFile ./neovim/plugins/mini-surround.lua;
      }

      (pkgs.vimUtils.buildVimPlugin {
        name = "mycolorscheme";
        src = pkgs.writeTextDir "lua/vitesse/init.lua" ''
          -- Plugin structure for a Neovim colorscheme
          -- ~/.config/nvim/lua/mycolorscheme/init.lua
          local M = {}

          -- Default options
          M.options = {
            transparent = false,
            italic_comments = true,
            bold_keywords = true,
            --additional options
          }

          -- Define the color palette
          M.colors = {
            -- Base colors
            bg = '#282c34',
            fg = '#abb2bf',

            -- Normal colors
            black = '#282c34',
            red = '#e06c75',
            green = '#98c379',
            yellow = '#e5c07b',
            blue = '#61afef',
            magenta = '#c678dd',
            cyan = '#56b6c2',
            white = '#abb2bf',

            -- Bright colors
            bright_black = '#5c6370',
            bright_red = '#e9969d',
            bright_green = '#b3d39c',
            bright_yellow = '#edd4a6',
            bright_blue = '#8fc6f4',
            bright_magenta = '#d7a1e7',
            bright_cyan = '#7bc6d0',
            bright_white = '#c8cdd5',

            -- UI specific colors
            gutter_bg = '#282c34',
            gutter_fg = '#4b5263',
            comment = '#7f848e',
            selection = '#3e4452',
            visual = '#3e4452',
            cursor_line = '#2c323c',
            indent_line = '#3b4048',
            pmenu_bg = '#3e4452',
            pmenu_sel = '#4b5263',

            -- Specialized
            error = '#f44747',
            warning = '#e5c07b',
            info = '#56b6c2',
            hint = '#98c379',
          }

          -- Setup function with options
          function M.setup(opts)
            -- Merge options
            if opts then
              M.options = vim.tbl_deep_extend("force", M.options, opts)
            end

            -- Clear existing highlights
            vim.cmd('highlight clear')

            if vim.fn.exists('syntax_on') then
              vim.cmd('syntax reset')
            end

            -- Set colorscheme name
            vim.g.colors_name = 'mycolorscheme'

            -- Load the scheme
            M.load()
          end

          -- Apply the color scheme
          function M.load()
            local c = M.colors
            local o = M.options

            -- Basic UI highlights
            local highlight_groups = {
              -- UI elements
              Normal = { fg = c.fg, bg = o.transparent and "NONE" or c.bg },
              NormalFloat = { fg = c.fg, bg = o.transparent and "NONE" or c.bg },
              StatusLine = { fg = c.fg, bg = c.selection },
              StatusLineNC = { fg = c.gutter_fg, bg = c.gutter_bg },
              VertSplit = { fg = c.indent_line, bg = c.bg },
              Cursor = { fg = c.bg, bg = c.fg },
              CursorLine = { bg = c.cursor_line },
              CursorLineNr = { fg = c.yellow, bold = true },
              LineNr = { fg = c.gutter_fg, bg = o.transparent and "NONE" or c.gutter_bg },
              SignColumn = { fg = c.fg, bg = o.transparent and "NONE" or c.gutter_bg },
              ColorColumn = { bg = c.cursor_line },
              Folded = { fg = c.comment, bg = c.gutter_bg },
              FoldColumn = { fg = c.comment, bg = o.transparent and "NONE" or c.gutter_bg },

              -- Search and selection
              Search = { fg = c.black, bg = c.yellow },
              IncSearch = { fg = c.black, bg = c.yellow },
              Visual = { bg = c.visual },
              VisualNOS = { bg = c.visual },

              -- Popup menus
              Pmenu = { fg = c.fg, bg = c.pmenu_bg },
              PmenuSel = { fg = c.fg, bg = c.pmenu_sel },
              PmenuSbar = { bg = c.pmenu_bg },
              PmenuThumb = { bg = c.fg },

              -- Messages
              ErrorMsg = { fg = c.error },
              WarningMsg = { fg = c.warning },
              MoreMsg = { fg = c.green },
              Question = { fg = c.green },

              -- Diagnostics
              DiagnosticError = { fg = c.error },
              DiagnosticWarn = { fg = c.warning },
              DiagnosticInfo = { fg = c.info },
              DiagnosticHint = { fg = c.hint },

              -- Syntax highlighting
              Comment = { fg = c.comment, italic = o.italic_comments },
              String = { fg = c.green },
              Character = { fg = c.green },
              Number = { fg = c.yellow },
              Float = { fg = c.yellow },
              Boolean = { fg = c.yellow },

              Identifier = { fg = c.red },
              Function = { fg = c.blue },

              Statement = { fg = c.purple },
              Conditional = { fg = c.purple, bold = o.bold_keywords },
              Repeat = { fg = c.purple, bold = o.bold_keywords },
              Label = { fg = c.purple },
              Operator = { fg = c.cyan },
              Keyword = { fg = c.purple, bold = o.bold_keywords },
              Exception = { fg = c.purple, bold = o.bold_keywords },

              PreProc = { fg = c.yellow },
              Include = { fg = c.purple },
              Define = { fg = c.purple },
              Macro = { fg = c.purple },
              PreCondit = { fg = c.yellow },

              Type = { fg = c.yellow },
              StorageClass = { fg = c.yellow },
              Structure = { fg = c.yellow },
              Typedef = { fg = c.yellow },

              Special = { fg = c.blue },
              SpecialChar = { fg = c.blue },
              Tag = { fg = c.blue },
              Delimiter = { fg = c.fg },
              SpecialComment = { fg = c.comment, italic = o.italic_comments },

              -- Diff
              DiffAdd = { fg = c.black, bg = c.green },
              DiffChange = { fg = c.black, bg = c.yellow },
              DiffDelete = { fg = c.black, bg = c.red },
              DiffText = { fg = c.black, bg = c.blue },

              -- Git
              gitcommitHeader = { fg = c.purple },
              gitcommitSelectedFile = { fg = c.green },
              gitcommitOverflow = { fg = c.red },

              -- Spelling
              SpellBad = { sp = c.error, undercurl = true },
              SpellCap = { sp = c.warning, undercurl = true },
              SpellRare = { sp = c.info, undercurl = true },
              SpellLocal = { sp = c.info, undercurl = true },

              -- Terminal colors
              Terminal = { fg = c.fg, bg = c.bg },
            }

            -- Apply highlight groups
            for group, styles in pairs(highlight_groups) do
              vim.api.nvim_set_hl(0, group, styles)
            end

            -- Set terminal colors
            vim.g.terminal_color_0 = c.black
            vim.g.terminal_color_1 = c.red
            vim.g.terminal_color_2 = c.green
            vim.g.terminal_color_3 = c.yellow
            vim.g.terminal_color_4 = c.blue
            vim.g.terminal_color_5 = c.magenta
            vim.g.terminal_color_6 = c.cyan
            vim.g.terminal_color_7 = c.white
            vim.g.terminal_color_8 = c.bright_black
            vim.g.terminal_color_9 = c.bright_red
            vim.g.terminal_color_10 = c.bright_green
            vim.g.terminal_color_11 = c.bright_yellow
            vim.g.terminal_color_12 = c.bright_blue
            vim.g.terminal_color_13 = c.bright_magenta
            vim.g.terminal_color_14 = c.bright_cyan
            vim.g.terminal_color_15 = c.bright_white

            -- Plugin specific highlights
            -- Tree-sitter
            highlight_groups["@function"] = { fg = c.blue }
            highlight_groups["@method"] = { fg = c.blue }
            highlight_groups["@constructor"] = { fg = c.blue }
            highlight_groups["@field"] = { fg = c.red }
            highlight_groups["@variable"] = { fg = c.red }
            highlight_groups["@parameter"] = { fg = c.red, italic = true }
            highlight_groups["@keyword"] = { fg = c.purple, bold = o.bold_keywords }
            highlight_groups["@string"] = { fg = c.green }
            highlight_groups["@number"] = { fg = c.yellow }
            highlight_groups["@boolean"] = { fg = c.yellow }
            highlight_groups["@comment"] = { fg = c.comment, italic = o.italic_comments }
            highlight_groups["@operator"] = { fg = c.cyan }

            -- Re-apply treesitter highlights
            for group, styles in pairs(highlight_groups) do
              if string.sub(group, 1, 1) == "@" then
                vim.api.nvim_set_hl(0, group, styles)
              end
            end
          end

          return M
        '';
      })
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./neovim/options.lua}
      ${builtins.readFile ./neovim/keymaps.lua}

      -- Make the undotree persist across sessions
      vim.o.undofile = true
      vim.o.undodir = "${config.xdg.dataHome}/nvim/undodir"
    '';
  };
}
