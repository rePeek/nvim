{
  # ══════════════════════════════════════════════
  #  Noice — Better Cmdline & Messages UI
  # ══════════════════════════════════════════════
  plugins.noice = {
    enable = true;
    settings = {
      lsp = {
        override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
          "cmp.entry.get_documentation" = true;
        };
      };
      routes = [
        {
          filter = {
            event = "msg_show";
            any = [
              { find = "%d+L, %d+B"; }
              { find = "; after #%d+"; }
              { find = "; before #%d+"; }
            ];
          };
          view = "mini";
        }
      ];
      presets = {
        bottom_search = true;
        command_palette = true;
        long_message_to_split = true;
        lsp_doc_border = true;
      };
    };
  };

  # ── Noice Keymaps ──
  keymaps = [
    {
      key = "<leader>snl";
      mode = "n";
      action = {
        __raw = "function() require('noice').cmd('last') end";
      };
      options = {
        desc = "Noice Last Message";
      };
    }
    {
      key = "<leader>snh";
      mode = "n";
      action = {
        __raw = "function() require('noice').cmd('history') end";
      };
      options = {
        desc = "Noice History";
      };
    }
    {
      key = "<leader>sna";
      mode = "n";
      action = {
        __raw = "function() require('noice').cmd('all') end";
      };
      options = {
        desc = "Noice All";
      };
    }
    {
      key = "<leader>snd";
      mode = "n";
      action = {
        __raw = "function() require('noice').cmd('dismiss') end";
      };
      options = {
        desc = "Dismiss All";
      };
    }
  ];
}
