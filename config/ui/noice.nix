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
      views = {
        cmdline_popup = {
          position = {
            # NUI's complex border shifts the outer frame up by one row.
            row = 3;
            col = "50%";
          };
          size = {
            width = 60;
            height = "auto";
          };
          border.padding = [
            0
            0
          ];
        };
        cmdline_popupmenu = {
          position = {
            row = 6;
            col = "50%";
          };
          size = {
            width = 60;
            height = "auto";
            max_height = 15;
          };
          border.padding = [
            0
            0
          ];
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
        bottom_search = false;
        command_palette = true;
        long_message_to_split = true;
        lsp_doc_border = true;
      };
    };
  };
}
