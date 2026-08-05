{
  # ══════════════════════════════════════════════
  #  Bufferline — Tab Bar (LazyVim-inspired)
  # ══════════════════════════════════════════════
  plugins.bufferline = {
    enable = true;
    settings = {
      options = {
        diagnostics = "nvim_lsp";
        always_show_bufferline = false;
        offsets = [
          {
            filetype = "snacks_layout_box";
          }
          {
            filetype = "oil";
            text = "File Explorer";
            highlight = "Directory";
            separator = true;
          }
        ];
      };
    };
  };

  # ── Bufferline Keymaps ──
  keymaps = [
    {
      key = "<leader>bp";
      mode = "n";
      action = "<Cmd>BufferLineTogglePin<CR>";
      options = {
        desc = "Toggle Pin";
      };
    }
    {
      key = "<leader>bP";
      mode = "n";
      action = "<Cmd>BufferLineGroupClose ungrouped<CR>";
      options = {
        desc = "Delete Non-Pinned Buffers";
      };
    }
    {
      key = "<leader>br";
      mode = "n";
      action = "<Cmd>BufferLineCloseRight<CR>";
      options = {
        desc = "Delete Buffers to the Right";
      };
    }
    {
      key = "<leader>bl";
      mode = "n";
      action = "<Cmd>BufferLineCloseLeft<CR>";
      options = {
        desc = "Delete Buffers to the Left";
      };
    }
    {
      key = "[B";
      mode = "n";
      action = "<cmd>BufferLineMovePrev<cr>";
      options = {
        desc = "Move buffer prev";
      };
    }
    {
      key = "]B";
      mode = "n";
      action = "<cmd>BufferLineMoveNext<cr>";
      options = {
        desc = "Move buffer next";
      };
    }
    {
      key = "<leader>bj";
      mode = "n";
      action = "<cmd>BufferLinePick<cr>";
      options = {
        desc = "Pick Buffer";
      };
    }
  ];
}
