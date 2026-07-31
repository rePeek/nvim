{
  # ── Leader ──
  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };

  # ── Editor Options ──
  opts = {
    number = true;
    relativenumber = true;

    shiftwidth = 4;
    tabstop = 4;
    softtabstop = 4;
    expandtab = true;
    smartindent = true;

    clipboard = "unnamedplus";
    signcolumn = "yes";
    cursorline = true;

    # Insert mode: bar cursor (Helix-style)
    guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20";

    scrolloff = 8;

    mouse = "a";
    showmode = false;

    splitright = true;
    splitbelow = true;
    wrap = false;

    undofile = true;
    swapfile = false;

    ignorecase = true;
    smartcase = true;

    termguicolors = true;
  };

  # ── Extra Lua Config (Helix-style) ──
  extraConfigLua = ''
    -- OSC 52 clipboard for remote/SSH sessions
    vim.g.clipboard = {
      name = 'OSC 52',
      copy = {
        ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
        ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
      },
      paste = {
        ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
        ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
      },
    }

    -- Diagnostic Styling (Helix-style)
    -- end-of-line hints, cursor-line warnings+
    vim.diagnostic.config({
      virtual_text = {
        spacing = 4,
        prefix = '●',
        severity = { min = vim.diagnostic.severity.HINT },
      },
      virtual_lines = {
        current_line = true,
        severity = { min = vim.diagnostic.severity.WARN },
      },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })
  '';

  # ── Auto Commands ──
  autoCmd = [
    # Highlight on yank
    {
      event = "TextYankPost";
      pattern = "*";
      callback = {
        __raw = "function() vim.highlight.on_yank() end";
      };
    }
    # Restore cursor position
    {
      event = "BufReadPost";
      pattern = "*";
      callback = {
        __raw = ''
          function()
            local mark = vim.api.nvim_buf_get_mark(0, '"')
            if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
              vim.api.nvim_win_set_cursor(0, mark)
            end
          end
        '';
      };
    }
    # Auto-save after delay (CursorHold = updatetime, default 4s)
    {
      event = [
        "CursorHold"
        "CursorHoldI"
      ];
      pattern = "*";
      callback = {
        __raw = "function() if vim.bo.buftype == '' then vim.cmd('silent! update') end end";
      };
    }
  ];
}
