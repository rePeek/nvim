{
  # ══════════════════════════════════════════════
  #  File Explorer — Oil.nvim
  # ══════════════════════════════════════════════
  plugins.oil = {
    enable = true;
    settings = {
      default_file_explorer = true;
      delete_to_trash = true;
      skip_confirm_for_simple_edits = true;
      view_options = {
        show_hidden = true;
      };
    };
  };

  # ══════════════════════════════════════════════
  #  Fuzzy Finder — Telescope
  # ══════════════════════════════════════════════
  plugins.telescope = {
    enable = true;
    settings = {
      defaults = {
        file_ignore_patterns = [
          "^.git/"
          "^result/"
          "^node_modules/"
        ];
      };
    };
  };

  # ══════════════════════════════════════════════
  #  Completion — nvim-cmp + LuaSnip
  # ══════════════════════════════════════════════
  plugins.cmp = {
    enable = true;
    autoEnableSources = true;
    settings = {
      sources = [
        { name = "nvim_lsp"; }
        { name = "luasnip"; }
        { name = "buffer"; }
        { name = "path"; }
      ];
      mapping = {
        "<C-n>" = "cmp.mapping.select_next_item()";
        "<C-p>" = "cmp.mapping.select_prev_item()";
        "<C-b>" = "cmp.mapping.scroll_docs(-4)";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<C-Space>" = "cmp.mapping.complete()";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<Tab>" = "cmp.mapping.select_next_item()";
        "<S-Tab>" = "cmp.mapping.select_prev_item()";
      };
    };
  };

  plugins.cmp-nvim-lsp.enable = true;
  plugins.cmp-buffer.enable = true;
  plugins.cmp-path.enable = true;
  plugins.cmp_luasnip.enable = true;

  plugins.luasnip.enable = true;

  # ══════════════════════════════════════════════
  #  Multi-cursor — multicursors.nvim (Helix-style)
  # ══════════════════════════════════════════════
  plugins.multicursors = {
    enable = true;
  };

  # ══════════════════════════════════════════════
  #  render-markdown.nvim — Markdown 渲染
  # ══════════════════════════════════════════════
  plugins.render-markdown = {
    enable = true;
    settings = {
      render_modes = [
        "n"
        "c"
        "t"
      ];

      anti_conceal = {
        enabled = false;
      };
    };
  };

  # ══════════════════════════════════════════════
  #  Which-Key (discoverable keymaps)
  # ══════════════════════════════════════════════
  plugins.which-key = {
    enable = true;
    settings = {
      spec = [
        {
          __unkeyed-1 = "<leader>f";
          group = "Find (Telescope)";
          mode = "n";
        }
        {
          __unkeyed-1 = "<leader>g";
          group = "Git";
          mode = "n";
        }
        {
          __unkeyed-1 = "<leader>d";
          group = "Debug (DAP)";
          mode = "n";
        }
        {
          __unkeyed-1 = "<leader>e";
          group = "Explorer";
          mode = "n";
        }
        {
          __unkeyed-1 = "<leader>b";
          group = "Buffer";
          mode = "n";
        }
        {
          __unkeyed-1 = "<leader>l";
          group = "LSP";
          mode = "n";
        }
        {
          __unkeyed-1 = "<leader>s";
          group = "Selection";
          mode = "n";
        }
      ];
    };
  };

}
