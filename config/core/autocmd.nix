{
  # ══════════════════════════════════════════════
  #  Auto Commands (LazyVim-inspired)
  # ══════════════════════════════════════════════
  autoCmd = [
    # ── Check for file changes on focus ──
    {
      event = [
        "FocusGained"
        "TermClose"
        "TermLeave"
      ];
      pattern = "*";
      callback = {
        __raw = ''
          function()
            if vim.o.buftype ~= "nofile" then
              vim.cmd("checktime")
            end
          end
        '';
      };
    }

    # ── Highlight on yank ──
    {
      event = "TextYankPost";
      pattern = "*";
      callback = {
        __raw = "function() (vim.hl or vim.highlight).on_yank() end";
      };
    }

    # ── Resize splits on VimResized ──
    {
      event = "VimResized";
      pattern = "*";
      callback = {
        __raw = ''
          function()
            local current_tab = vim.fn.tabpagenr()
            vim.cmd("tabdo wincmd =")
            vim.cmd("tabnext " .. current_tab)
          end
        '';
      };
    }

    # ── Restore cursor position ──
    {
      event = "BufReadPost";
      pattern = "*";
      callback = {
        __raw = ''
          function(event)
            local exclude = { "gitcommit" }
            local buf = event.buf
            if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
              return
            end
            vim.b[buf].lazyvim_last_loc = true
            local mark = vim.api.nvim_buf_get_mark(buf, '"')
            local lcount = vim.api.nvim_buf_line_count(buf)
            if mark[1] > 0 and mark[1] <= lcount then
              pcall(vim.api.nvim_win_set_cursor, 0, mark)
            end
          end
        '';
      };
    }

    # ── Close certain filetypes with <q> ──
    {
      event = "FileType";
      pattern = [
        "checkhealth"
        "dap-float"
        "gitsigns-blame"
        "grug-far"
        "help"
        "lspinfo"
        "notify"
        "qf"
        "startuptime"
      ];
      callback = {
        __raw = ''
          function(event)
            vim.bo[event.buf].buflisted = false
            vim.schedule(function()
              vim.keymap.set("n", "q", function()
                vim.cmd("close")
                pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
              end, { buffer = event.buf, silent = true, desc = "Quit buffer" })
            end)
          end
        '';
      };
    }

    # ── Man pages unlisted ──
    {
      event = "FileType";
      pattern = "man";
      callback = {
        __raw = ''
          function(event)
            vim.bo[event.buf].buflisted = false
          end
        '';
      };
    }

    # ── Wrap + spell for text filetypes ──
    {
      event = "FileType";
      pattern = [
        "text"
        "plaintex"
        "gitcommit"
        "markdown"
      ];
      callback = {
        __raw = ''
          function()
            vim.opt_local.wrap = true
          end
        '';
      };
    }

    # ── Fix conceallevel for JSON ──
    {
      event = "FileType";
      pattern = [
        "json"
        "jsonc"
        "json5"
      ];
      callback = {
        __raw = ''
          function()
            vim.opt_local.conceallevel = 0
          end
        '';
      };
    }

    # ── Auto-create parent dirs on save ──
    {
      event = "BufWritePre";
      pattern = "*";
      callback = {
        __raw = ''
          function(event)
            if event.match:match("^%w%w+:[\\/][\\/]") then
              return
            end
            local file = vim.uv.fs_realpath(event.match) or event.match
            vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
          end
        '';
      };
    }

    # ── Auto-save after idle ──
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
