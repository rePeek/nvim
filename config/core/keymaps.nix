{
  # ══════════════════════════════════════════════
  #  Keymaps (LazyVim-inspired)
  # ══════════════════════════════════════════════
  keymaps = [
    # ── Better Up/Down (respect wrapped lines with count) ──
    {
      key = "j";
      mode = [
        "n"
        "x"
      ];
      action = {
        __raw = "function() return vim.v.count == 0 and 'gj' or 'j' end";
      };
      options = {
        desc = "Down";
        expr = true;
        silent = true;
      };
    }
    {
      key = "k";
      mode = [
        "n"
        "x"
      ];
      action = {
        __raw = "function() return vim.v.count == 0 and 'gk' or 'k' end";
      };
      options = {
        desc = "Up";
        expr = true;
        silent = true;
      };
    }

    # ── Window Navigation ──
    {
      key = "<C-h>";
      mode = "n";
      action = "<C-w>h";
      options = {
        desc = "Go to Left Window";
        remap = true;
      };
    }
    {
      key = "<C-j>";
      mode = "n";
      action = "<C-w>j";
      options = {
        desc = "Go to Lower Window";
        remap = true;
      };
    }
    {
      key = "<C-k>";
      mode = "n";
      action = "<C-w>k";
      options = {
        desc = "Go to Upper Window";
        remap = true;
      };
    }
    {
      key = "<C-l>";
      mode = "n";
      action = "<C-w>l";
      options = {
        desc = "Go to Right Window";
        remap = true;
      };
    }

    # ── Resize Window with Shift+Ctrl+Arrows ──
    {
      key = "<C-S-Up>";
      mode = "n";
      action = "<cmd>resize +2<CR>";
      options = {
        desc = "Increase Window Height";
      };
    }
    {
      key = "<C-S-Down>";
      mode = "n";
      action = "<cmd>resize -2<CR>";
      options = {
        desc = "Decrease Window Height";
      };
    }
    {
      key = "<C-S-Left>";
      mode = "n";
      action = "<cmd>vertical resize -2<CR>";
      options = {
        desc = "Decrease Window Width";
      };
    }
    {
      key = "<C-S-Right>";
      mode = "n";
      action = "<cmd>vertical resize +2<CR>";
      options = {
        desc = "Increase Window Width";
      };
    }

    # ── Jumplist Navigation ──
    {
      key = "<C-Left>";
      mode = "n";
      action = "<C-o>";
      options = {
        desc = "Jump Back";
      };
    }
    {
      key = "<C-Right>";
      mode = "n";
      action = "<C-i>";
      options = {
        desc = "Jump Forward";
      };
    }

    # ── Move Lines (Alt+Up/Down) ──
    {
      key = "<A-Down>";
      mode = "n";
      action = "<cmd>execute 'move .+' . v:count1<CR>==";
      options = {
        desc = "Move Down";
      };
    }
    {
      key = "<A-Up>";
      mode = "n";
      action = "<cmd>execute 'move .-' . (v:count1 + 1)<CR>==";
      options = {
        desc = "Move Up";
      };
    }
    {
      key = "<A-Down>";
      mode = "i";
      action = "<Esc><cmd>m .+1<CR>==gi";
      options = {
        desc = "Move Down";
      };
    }
    {
      key = "<A-Up>";
      mode = "i";
      action = "<Esc><cmd>m .-2<CR>==gi";
      options = {
        desc = "Move Up";
      };
    }
    {
      key = "<A-Down>";
      mode = "v";
      action = ":<C-u>execute \"'<,'>move '>+\" . v:count1<CR>gv=gv";
      options = {
        desc = "Move Down";
      };
    }
    {
      key = "<A-Up>";
      mode = "v";
      action = ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<CR>gv=gv";
      options = {
        desc = "Move Up";
      };
    }

    # ── Buffer Navigation ──
    {
      key = "<S-Left>";
      mode = "n";
      action = "<cmd>bprevious<CR>";
      options = {
        desc = "Prev Buffer";
      };
    }
    {
      key = "<S-Right>";
      mode = "n";
      action = "<cmd>bnext<CR>";
      options = {
        desc = "Next Buffer";
      };
    }
    {
      key = "[b";
      mode = "n";
      action = "<cmd>bprevious<CR>";
      options = {
        desc = "Prev Buffer";
      };
    }
    {
      key = "]b";
      mode = "n";
      action = "<cmd>bnext<CR>";
      options = {
        desc = "Next Buffer";
      };
    }
    {
      key = "<leader>b";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.buffers() end";
      };
      options = {
        desc = "Buffer Picker";
      };
    }

    # ── Clear Search & Snippet Stop on Escape ──
    {
      key = "<Esc>";
      mode = [
        "i"
        "n"
        "s"
        "x"
      ];
      action = {
        __raw = ''
          function()
            vim.cmd("noh")
            return "<esc>"
          end
        '';
      };
      options = {
        expr = true;
        desc = "Clear highlights and return to normal mode";
      };
    }

    # ── Clear Search / Diff Update / Redraw ──
    {
      key = "<leader>ur";
      mode = "n";
      action = "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>";
      options = {
        desc = "Redraw / Clear hlsearch / Diff Update";
      };
    }

    # ── Better n/N Search Navigation (opens folds) ──
    {
      key = "n";
      mode = [
        "n"
        "x"
        "o"
      ];
      action = {
        __raw = "function() return (vim.v.searchforward == 1 and 'n' or 'N') .. 'zv' end";
      };
      options = {
        expr = true;
        desc = "Next Search Result";
      };
    }
    {
      key = "N";
      mode = [
        "n"
        "x"
        "o"
      ];
      action = {
        __raw = "function() return (vim.v.searchforward == 1 and 'N' or 'n') .. 'zv' end";
      };
      options = {
        expr = true;
        desc = "Prev Search Result";
      };
    }

    # ── Undo Break-points ──
    {
      key = ",";
      mode = "i";
      action = ",<c-g>u";
      options = {
        desc = "Undo break-point on comma";
      };
    }
    {
      key = ".";
      mode = "i";
      action = ".<c-g>u";
      options = {
        desc = "Undo break-point on dot";
      };
    }
    {
      key = ";";
      mode = "i";
      action = ";<c-g>u";
      options = {
        desc = "Undo break-point on semicolon";
      };
    }

    # ── Save File ──
    {
      key = "<C-s>";
      mode = [
        "i"
        "x"
        "n"
        "s"
      ];
      action = "<cmd>w<CR><Esc>";
      options = {
        desc = "Save File";
      };
    }

    # ── Better Indenting ──
    {
      key = "<";
      mode = "x";
      action = "<gv";
      options = {
        desc = "Indent left & reselect";
      };
    }
    {
      key = ">";
      mode = "x";
      action = ">gv";
      options = {
        desc = "Indent right & reselect";
      };
    }

    # ── Commenting ──
    {
      key = "<leader>cc";
      mode = [
        "n"
        "x"
      ];
      action = "gcc";
      options = {
        desc = "Toggle Comment";
        remap = true;
      };
    }
    {
      key = "<leader>co";
      mode = "n";
      action = "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>";
      options = {
        desc = "Add Comment Below";
      };
    }
    {
      key = "<leader>cO";
      mode = "n";
      action = "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>";
      options = {
        desc = "Add Comment Above";
      };
    }
    {
      key = "gco";
      mode = "n";
      action = "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>";
      options = {
        desc = "Add Comment Below";
      };
    }
    {
      key = "gcO";
      mode = "n";
      action = "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>";
      options = {
        desc = "Add Comment Above";
      };
    }

    # ── Quit ──
    {
      key = "<leader>q";
      mode = "n";
      action = "<cmd>qa<CR>";
      options = {
        desc = "Quit All";
      };
    }

    # ── Windows / Splits ──
    {
      key = "<leader>-";
      mode = "n";
      action = "<C-W>s";
      options = {
        desc = "Split Window Below";
        remap = true;
      };
    }
    {
      key = "<leader>|";
      mode = "n";
      action = "<C-W>v";
      options = {
        desc = "Split Window Right";
        remap = true;
      };
    }
    {
      key = "<leader>wd";
      mode = "n";
      action = "<C-W>c";
      options = {
        desc = "Delete Window";
        remap = true;
      };
    }

    # ── Diagnostic Navigation ──
    {
      key = "<leader>cd";
      mode = "n";
      action = {
        __raw = "function() vim.diagnostic.open_float() end";
      };
      options = {
        desc = "Line Diagnostics";
      };
    }
    {
      key = "]d";
      mode = "n";
      action = {
        __raw = ''
          function()
            vim.diagnostic.jump({ count = 1, float = true })
          end
        '';
      };
      options = {
        desc = "Next Diagnostic";
      };
    }
    {
      key = "[d";
      mode = "n";
      action = {
        __raw = ''
          function()
            vim.diagnostic.jump({ count = -1, float = true })
          end
        '';
      };
      options = {
        desc = "Prev Diagnostic";
      };
    }
    {
      key = "]e";
      mode = "n";
      action = {
        __raw = ''
          function()
            vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR, float = true })
          end
        '';
      };
      options = {
        desc = "Next Error";
      };
    }
    {
      key = "[e";
      mode = "n";
      action = {
        __raw = ''
          function()
            vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR, float = true })
          end
        '';
      };
      options = {
        desc = "Prev Error";
      };
    }
    {
      key = "]w";
      mode = "n";
      action = {
        __raw = ''
          function()
            vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN, float = true })
          end
        '';
      };
      options = {
        desc = "Next Warning";
      };
    }
    {
      key = "[w";
      mode = "n";
      action = {
        __raw = ''
          function()
            vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN, float = true })
          end
        '';
      };
      options = {
        desc = "Prev Warning";
      };
    }

    # ── Quickfix List ──
    {
      key = "<leader>xq";
      mode = "n";
      action = {
        __raw = ''
          function()
            local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
            if not success and err then vim.notify(err, vim.log.levels.ERROR) end
          end
        '';
      };
      options = {
        desc = "Quickfix List";
      };
    }
    {
      key = "[q";
      mode = "n";
      action = "<cmd>cprev<CR>";
      options = {
        desc = "Previous Quickfix";
      };
    }
    {
      key = "]q";
      mode = "n";
      action = "<cmd>cnext<CR>";
      options = {
        desc = "Next Quickfix";
      };
    }

    # ── Location List ──
    {
      key = "<leader>xl";
      mode = "n";
      action = {
        __raw = ''
          function()
            local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
            if not success and err then vim.notify(err, vim.log.levels.ERROR) end
          end
        '';
      };
      options = {
        desc = "Location List";
      };
    }

    # ── Snacks Toggle Keymaps ──
    {
      key = "<leader>uf";
      mode = "n";
      action = {
        __raw = ''
          function()
            require("snacks").toggle.option("formatexpr"):toggle()
          end
        '';
      };
      options = {
        desc = "Toggle Auto Format";
      };
    }
    {
      key = "<leader>us";
      mode = "n";
      action = {
        __raw = ''
          function() require("snacks").toggle.option("spell", { name = "Spelling" }):toggle() end
        '';
      };
      options = {
        desc = "Toggle Spelling";
      };
    }
    {
      key = "<leader>uw";
      mode = "n";
      action = {
        __raw = ''
          function() require("snacks").toggle.option("wrap", { name = "Wrap" }):toggle() end
        '';
      };
      options = {
        desc = "Toggle Wrap";
      };
    }
    {
      key = "<leader>ul";
      mode = "n";
      action = {
        __raw = ''
          function() require("snacks").toggle.line_number():toggle() end
        '';
      };
      options = {
        desc = "Toggle Line Numbers";
      };
    }
    {
      key = "<leader>ud";
      mode = "n";
      action = {
        __raw = ''
          function() require("snacks").toggle.diagnostics():toggle() end
        '';
      };
      options = {
        desc = "Toggle Diagnostics";
      };
    }
    {
      key = "<leader>uL";
      mode = "n";
      action = {
        __raw = ''
          function() require("snacks").toggle.option("relativenumber", { name = "Relative Number" }):toggle() end
        '';
      };
      options = {
        desc = "Toggle Relative Number";
      };
    }
    {
      key = "<leader>uc";
      mode = "n";
      action = {
        __raw = ''
          function()
            require("snacks").toggle.option("conceallevel", {
              off = 0,
              on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2,
              name = "Conceal Level"
            }):toggle()
          end
        '';
      };
      options = {
        desc = "Toggle Conceal Level";
      };
    }
    {
      key = "<leader>ub";
      mode = "n";
      action = {
        __raw = ''
          function()
            require("snacks").toggle.option("background", {
              off = "light", on = "dark", name = "Dark Background"
            }):toggle()
          end
        '';
      };
      options = {
        desc = "Toggle Dark Background";
      };
    }
    {
      key = "<leader>ug";
      mode = "n";
      action = {
        __raw = ''
          function() require("snacks").toggle.indent():toggle() end
        '';
      };
      options = {
        desc = "Toggle Indent Guides";
      };
    }
    {
      key = "<leader>ua";
      mode = "n";
      action = {
        __raw = ''
          function() require("snacks").toggle.animate():toggle() end
        '';
      };
      options = {
        desc = "Toggle Animations";
      };
    }
    {
      key = "<leader>uZ";
      mode = "n";
      action = {
        __raw = ''
          function() require("snacks").toggle.zoom():toggle() end
        '';
      };
      options = {
        desc = "Toggle Zoom";
      };
    }
    {
      key = "<leader>uz";
      mode = "n";
      action = {
        __raw = ''
          function() require("snacks").toggle.zen():toggle() end
        '';
      };
      options = {
        desc = "Toggle Zen Mode";
      };
    }

    # ── Inlay Hints ──
    {
      key = "<leader>uh";
      mode = "n";
      action = {
        __raw = ''
          function()
            if vim.lsp.inlay_hint then
              require("snacks").toggle.inlay_hints():toggle()
            end
          end
        '';
      };
      options = {
        desc = "Toggle Inlay Hints";
      };
    }

    # ── Inspect ──
    {
      key = "<leader>ui";
      mode = "n";
      action = {
        __raw = "function() vim.show_pos() end";
      };
      options = {
        desc = "Inspect Pos";
      };
    }

    # ── Selection Keymaps (keep from original) ──
    {
      key = "<leader>ss";
      mode = "n";
      action = "viw";
      options = {
        desc = "Select word";
      };
    }
    {
      key = "<leader>sl";
      mode = "n";
      action = "V";
      options = {
        desc = "Select line";
      };
    }
    {
      key = "<leader>s%";
      mode = "n";
      action = "ggVG";
      options = {
        desc = "Select all";
      };
    }

    # ── Visual Mode: Move Lines ──
    {
      key = "J";
      mode = "v";
      action = ":m '>+1<CR>gv=gv";
      options = {
        desc = "Move selection down";
      };
    }
    {
      key = "K";
      mode = "v";
      action = ":m '<-2<CR>gv=gv";
      options = {
        desc = "Move selection up";
      };
    }
  ];
}
