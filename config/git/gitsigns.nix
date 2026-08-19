{
  # ══════════════════════════════════════════════
  #  Gitsigns — Inline Git Decorations (LazyVim-style)
  # ══════════════════════════════════════════════
  plugins.gitsigns = {
    enable = true;
    settings = {
      numhl = true;
      linehl = true;
      signs = {
        add = {
          text = "█";
        };
        change = {
          text = "█";
        };
        delete = {
          text = "";
        };
        topdelete = {
          text = "";
        };
        changedelete = {
          text = "█";
        };
        untracked = {
          text = "█";
        };
      };
      signs_staged = {
        add = {
          text = "█";
        };
        change = {
          text = "█";
        };
        delete = {
          text = "";
        };
        topdelete = {
          text = "";
        };
        changedelete = {
          text = "█";
        };
      };
      current_line_blame = true;
      current_line_blame_opts = {
        virt_text = true;
        delay = 500;
      };
    };
  };

  # ── Gitsigns Keymaps (LazyVim-style) ──
  keymaps = [
    {
      key = "]h";
      mode = "n";
      action = {
        __raw = ''
          function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              require("gitsigns").nav_hunk("next")
            end
          end
        '';
      };
      options = {
        desc = "Next Hunk";
      };
    }
    {
      key = "[h";
      mode = "n";
      action = {
        __raw = ''
          function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              require("gitsigns").nav_hunk("prev")
            end
          end
        '';
      };
      options = {
        desc = "Prev Hunk";
      };
    }
    {
      key = "]H";
      mode = "n";
      action = {
        __raw = "function() require('gitsigns').nav_hunk('last') end";
      };
      options = {
        desc = "Last Hunk";
      };
    }
    {
      key = "[H";
      mode = "n";
      action = {
        __raw = "function() require('gitsigns').nav_hunk('first') end";
      };
      options = {
        desc = "First Hunk";
      };
    }
    {
      key = "<leader>gs";
      mode = [
        "n"
        "x"
      ];
      action = ":Gitsigns stage_hunk<CR>";
      options = {
        desc = "Stage Hunk";
      };
    }
    {
      key = "<leader>gr";
      mode = [
        "n"
        "x"
      ];
      action = ":Gitsigns reset_hunk<CR>";
      options = {
        desc = "Reset Hunk";
      };
    }
    {
      key = "<leader>gS";
      mode = "n";
      action = {
        __raw = "function() require('gitsigns').stage_buffer() end";
      };
      options = {
        desc = "Stage Buffer";
      };
    }
    {
      key = "<leader>gu";
      mode = "n";
      action = {
        __raw = "function() require('gitsigns').undo_stage_hunk() end";
      };
      options = {
        desc = "Undo Stage Hunk";
      };
    }
    {
      key = "<leader>gR";
      mode = "n";
      action = {
        __raw = "function() require('gitsigns').reset_buffer() end";
      };
      options = {
        desc = "Reset Buffer";
      };
    }
    {
      key = "<leader>gp";
      mode = "n";
      action = {
        __raw = "function() require('gitsigns').preview_hunk_inline() end";
      };
      options = {
        desc = "Preview Hunk Inline";
      };
    }
    {
      key = "<leader>gbl";
      mode = "n";
      action = {
        __raw = "function() require('gitsigns').blame_line({ full = true }) end";
      };
      options = {
        desc = "Blame Line";
      };
    }
    {
      key = "<leader>gbb";
      mode = "n";
      action = {
        __raw = "function() require('gitsigns').blame() end";
      };
      options = {
        desc = "Blame Buffer";
      };
    }
    {
      key = "<leader>gd";
      mode = "n";
      action = {
        __raw = "function() require('gitsigns').diffthis() end";
      };
      options = {
        desc = "Diff This";
      };
    }
    {
      key = "<leader>gD";
      mode = "n";
      action = {
        __raw = "function() require('gitsigns').diffthis('~') end";
      };
      options = {
        desc = "Diff This ~";
      };
    }
    {
      key = "ih";
      mode = [
        "o"
        "x"
      ];
      action = ":<C-U>Gitsigns select_hunk<CR>";
      options = {
        desc = "GitSigns Select Hunk";
      };
    }
    {
      key = "<leader>uG";
      mode = "n";
      action = {
        __raw = ''
          function()
            require("snacks").toggle({
              name = "Git Signs",
              get = function() return require("gitsigns.config").config.signcolumn end,
              set = function(state) require("gitsigns").toggle_signs(state) end,
            }):toggle()
          end
        '';
      };
      options = {
        desc = "Toggle Git Signs";
      };
    }
  ];
}
