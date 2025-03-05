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
      nvim-cmp
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
        config = toLuaFile ./neovim/plugin/tiny-inline-diagnostic.lua;
      }
      {
        plugin = autoclose-nvim;
        config = toLuaFile ./neovim/plugin/autoclose.lua;
      }
      {
        plugin = tabout-nvim;
        config = toLuaFile ./neovim/plugin/tabout.lua;
      }
      {
        plugin = conform-nvim;
        config = toLuaFile ./neovim/plugin/conform.lua;
      }
      {
        plugin = nvim-tree-lua;
        config = toLuaFile ./neovim/plugin/nvim-tree.lua;
      }
      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./neovim/plugin/lsp.lua;
      }
      {
        plugin = comment-nvim;
        config = toLuaFile ./neovim/plugin/comment.lua;
      }
      {
        plugin = nvim-cmp;
        config = toLuaFile ./neovim/plugin/cmp.lua;
      }
      {
        plugin = telescope-nvim;
        config = toLuaFile ./neovim/plugin/telescope.lua;
      }
      {
        plugin = lualine-nvim;
        config = toLuaFile ./neovim/plugin/lualine.lua;
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
          p.tree-sitter-metal
        ]);
        config = toLuaFile ./neovim/plugin/treesitter.lua;
      }

      {
        plugin = fromGitHub "echasnovski/mini.surround" "main" "aa5e245829dd12d8ff0c96ef11da28681d6049aa";
        config = toLuaFile ./neovim/plugin/mini-surround.lua;
      }
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
