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

      # color schemes
      gruvbox-material
      everforest
      kanagawa-nvim
      kanagawa-paper-nvim

      {
        plugin = treesj;
        config = toLua "require('treesj').setup()";
      }
      # {
      #   plugin = lsp_lines-nvim;
      #   config = toLuaFile ./neovim/plugin/lsp-lines.lua;
      # }
      # {
      #   plugin = tiny-inline-diagnostic-nvim;
      #   config = toLuaFile ./neovim/plugins/tiny-inline-diagnostic.lua;
      # }
      {
        plugin = autoclose-nvim;
        config = toLuaFile ./neovim/plugins/autoclose.lua;
      }
      # {
      #   plugin = tabout-nvim;
      #   config = toLuaFile ./neovim/plugins/tabout.lua;
      # }
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
        plugin = nvim-treesitter.withAllGrammars;
        # plugin = nvim-treesitter.withPlugins (p: [
        #   p.nix
        #   p.vim
        #   p.bash
        #   p.lua
        #   p.python
        #   p.json
        #   p.toml
        #   p.zig
        #   p.go
        #   p.rust
        #   p.typescript
        #   p.javascript
        #   p.svelte
        #   p.yuck
        #   p.typst
        #   p.markdown
        #   p.glsl
        #   p.c
        #   p.cpp
        # ]);
        config = toLuaFile ./neovim/plugins/treesitter.lua;
      }
      {
        plugin = fromGitHub "echasnovski/mini.surround" "main" "aa5e245829dd12d8ff0c96ef11da28681d6049aa";
        config = toLuaFile ./neovim/plugins/mini-surround.lua;
      }

      (pkgs.vimUtils.buildVimPlugin {
        name = "vitesse";
        src = pkgs.writeTextDir "lua/vitesse/init.lua" (builtins.readFile ./neovim/themes/vitesse.lua);
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
