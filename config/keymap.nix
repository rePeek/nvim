{
  # ══════════════════════════════════════════════
  #  Keymaps (unified from all modules)
  # ══════════════════════════════════════════════
  keymaps = [
    # ══════════════════════════════════════════════
    #  Telescope — Fuzzy Finder
    # ══════════════════════════════════════════════
    {
      key = "<leader>/";
      mode = "n";
      action = "<cmd>Telescope live_grep<CR>";
      options = {
        desc = "Live grep";
      };
    }
    {
      key = "<leader> ";
      mode = "n";
      action = "<cmd>Telescope find_files<CR>";
      options = {
        desc = "Find files";
      };
    }
    {
      key = "<leader>,";
      mode = "n";
      action = "<cmd>Telescope commands<CR>";
      options = {
        desc = "Command palette";
      };
    }
    {
      key = "<leader>ff";
      mode = "n";
      action = "<cmd>Telescope find_files<CR>";
      options = {
        desc = "Find files";
      };
    }
    {
      key = "<leader>fg";
      mode = "n";
      action = "<cmd>Telescope live_grep<CR>";
      options = {
        desc = "Live grep";
      };
    }
    {
      key = "<leader>fb";
      mode = "n";
      action = "<cmd>Telescope buffers<CR>";
      options = {
        desc = "Buffers";
      };
    }
    {
      key = "<leader>fh";
      mode = "n";
      action = "<cmd>Telescope help_tags<CR>";
      options = {
        desc = "Help tags";
      };
    }
    {
      key = "<leader>fr";
      mode = "n";
      action = "<cmd>Telescope oldfiles<CR>";
      options = {
        desc = "Recent files";
      };
    }
    {
      key = "<leader>fs";
      mode = "n";
      action = "<cmd>Telescope grep_string<CR>";
      options = {
        desc = "Grep string under cursor";
      };
    }
    {
      key = "<leader>fd";
      mode = "n";
      action = "<cmd>Telescope diagnostics<CR>";
      options = {
        desc = "Diagnostics";
      };
    }
    {
      key = "<leader>fk";
      mode = "n";
      action = "<cmd>Telescope keymaps<CR>";
      options = {
        desc = "Keymaps";
      };
    }

    # ══════════════════════════════════════════════
    #  File Explorer — Oil
    # ══════════════════════════════════════════════
    {
      key = "<leader>e";
      mode = "n";
      action = "<cmd>Oil<CR>";
      options = {
        desc = "Oil file explorer";
      };
    }
    {
      key = "-";
      mode = "n";
      action = "<cmd>Oil<CR>";
      options = {
        desc = "Oil (Helix-style dash)";
      };
    }

    # ══════════════════════════════════════════════
    #  Buffer Navigation
    # ══════════════════════════════════════════════
    {
      key = "<S-h>";
      mode = "n";
      action = "<cmd>bprevious<CR>";
      options = {
        desc = "Previous buffer";
      };
    }
    {
      key = "<S-l>";
      mode = "n";
      action = "<cmd>bnext<CR>";
      options = {
        desc = "Next buffer";
      };
    }
    {
      key = "<leader>bc";
      mode = "n";
      action = "<cmd>bdelete<CR>";
      options = {
        desc = "Close buffer";
      };
    }
    {
      key = "<leader>bx";
      mode = "n";
      action = "<cmd>bdelete!<CR>";
      options = {
        desc = "Force close buffer";
      };
    }
    {
      key = "<leader>bo";
      mode = "n";
      action = "<cmd>%bdelete|e#<CR>";
      options = {
        desc = "Close all other buffers";
      };
    }
    {
      key = "<leader>bl";
      mode = "n";
      action = "<cmd>Telescope buffers<CR>";
      options = {
        desc = "List buffers";
      };
    }
    {
      key = "<leader>bn";
      mode = "n";
      action = "<cmd>enew<CR>";
      options = {
        desc = "New buffer";
      };
    }

    # ══════════════════════════════════════════════
    #  Window Navigation
    # ══════════════════════════════════════════════
    {
      key = "<C-h>";
      mode = "n";
      action = "<C-w>h";
      options = {
        desc = "Window left";
      };
    }
    {
      key = "<C-j>";
      mode = "n";
      action = "<C-w>j";
      options = {
        desc = "Window down";
      };
    }
    {
      key = "<C-k>";
      mode = "n";
      action = "<C-w>k";
      options = {
        desc = "Window up";
      };
    }

    # ══════════════════════════════════════════════
    #  Quick Save & Quit
    # ══════════════════════════════════════════════
    {
      key = "<leader>w";
      mode = "n";
      action = "<cmd>w<CR>";
      options = {
        desc = "Save";
      };
    }
    {
      key = "<leader>q";
      mode = "n";
      action = "<cmd>q<CR>";
      options = {
        desc = "Quit";
      };
    }
    {
      key = "<leader>Q";
      mode = "n";
      action = "<cmd>qall<CR>";
      options = {
        desc = "Quit all";
      };
    }

    # ══════════════════════════════════════════════
    #  Move Lines
    # ══════════════════════════════════════════════
    {
      key = "<A-j>";
      mode = [
        "n"
        "v"
      ];
      action = "<cmd>m .+1<CR>==";
      options = {
        desc = "Move line down";
      };
    }
    {
      key = "<A-k>";
      mode = [
        "n"
        "v"
      ];
      action = "<cmd>m .-2<CR>==";
      options = {
        desc = "Move line up";
      };
    }

    # ══════════════════════════════════════════════
    #  Selection Enhancements
    # ══════════════════════════════════════════════
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
    {
      key = "<leader>si";
      mode = "n";
      action = "vi(";
      options = {
        desc = "Select inside parens";
      };
    }
    {
      key = "<leader>sa";
      mode = "n";
      action = "va(";
      options = {
        desc = "Select around parens";
      };
    }
    {
      key = "<leader>si\"";
      mode = "n";
      action = "vi\"";
      options = {
        desc = "Select inside quotes";
      };
    }

    # ══════════════════════════════════════════════
    #  Go-to Shortcuts (via Telescope)
    # ══════════════════════════════════════════════
    {
      key = "<leader>gf";
      mode = "n";
      action = "<cmd>Telescope git_files<CR>";
      options = {
        desc = "Git files";
      };
    }
    {
      key = "<leader>gj";
      mode = "n";
      action = "<cmd>Telescope jumplist<CR>";
      options = {
        desc = "Jumplist";
      };
    }
    {
      key = "<leader>gm";
      mode = "n";
      action = "<cmd>Telescope marks<CR>";
      options = {
        desc = "Marks";
      };
    }

    # ══════════════════════════════════════════════
    #  Git (Gitsigns + LazyGit)
    # ══════════════════════════════════════════════
    {
      key = "<leader>gg";
      mode = "n";
      action = "<cmd>LazyGit<CR>";
      options = {
        desc = "LazyGit";
      };
    }
    {
      key = "<leader>gh";
      mode = "n";
      action = {
        __raw = "function() require('gitsigns').preview_hunk() end";
      };
      options = {
        desc = "Preview hunk";
      };
    }
    {
      key = "<leader>gd";
      mode = "n";
      action = {
        __raw = "function() require('gitsigns').diffthis() end";
      };
      options = {
        desc = "Diff this";
      };
    }
    {
      key = "<leader>gb";
      mode = "n";
      action = {
        __raw = "function() require('gitsigns').blame_line() end";
      };
      options = {
        desc = "Blame line";
      };
    }
    {
      key = "]c";
      mode = "n";
      action = {
        __raw = "function() require('gitsigns').next_hunk() end";
      };
      options = {
        desc = "Next hunk";
      };
    }
    {
      key = "[c";
      mode = "n";
      action = {
        __raw = "function() require('gitsigns').prev_hunk() end";
      };
      options = {
        desc = "Previous hunk";
      };
    }
    {
      key = "<A-b>";
      mode = "n";
      action = {
        __raw = ''
          function()
            local line = vim.fn.line('.')
            local file = vim.fn.expand('%')
            local result = vim.fn.system('git blame -L ' .. line .. ',+1 ' .. file)
            vim.api.nvim_echo({{ vim.trim(result), 'Normal' }}, false, {})
          end
        '';
      };
      options = {
        desc = "Git blame current line";
      };
    }

    # ══════════════════════════════════════════════
    #  DAP (Debug)
    # ══════════════════════════════════════════════
    {
      key = "<leader>db";
      mode = "n";
      action = {
        __raw = "function() require('dap').toggle_breakpoint() end";
      };
      options = {
        desc = "Toggle breakpoint";
      };
    }
    {
      key = "<leader>dc";
      mode = "n";
      action = {
        __raw = "function() require('dap').continue() end";
      };
      options = {
        desc = "Continue";
      };
    }
    {
      key = "<leader>dn";
      mode = "n";
      action = {
        __raw = "function() require('dap').step_over() end";
      };
      options = {
        desc = "Step over";
      };
    }
    {
      key = "<leader>ds";
      mode = "n";
      action = {
        __raw = "function() require('dap').step_into() end";
      };
      options = {
        desc = "Step into";
      };
    }
    {
      key = "<leader>do";
      mode = "n";
      action = {
        __raw = "function() require('dap').step_out() end";
      };
      options = {
        desc = "Step out";
      };
    }
    {
      key = "<leader>dr";
      mode = "n";
      action = {
        __raw = "function() require('dap').restart() end";
      };
      options = {
        desc = "Restart";
      };
    }
    {
      key = "<leader>dt";
      mode = "n";
      action = {
        __raw = "function() require('dap').terminate() end";
      };
      options = {
        desc = "Terminate";
      };
    }
    {
      key = "<leader>du";
      mode = "n";
      action = {
        __raw = "function() require('dapui').toggle() end";
      };
      options = {
        desc = "Toggle DAP UI";
      };
    }

    # ══════════════════════════════════════════════
    #  Visual Mode
    # ══════════════════════════════════════════════
    {
      key = "<";
      mode = "v";
      action = "<gv";
      options = {
        desc = "Indent left & reselect";
      };
    }
    {
      key = ">";
      mode = "v";
      action = ">gv";
      options = {
        desc = "Indent right & reselect";
      };
    }
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

    # ══════════════════════════════════════════════
    #  Misc (Helix-style)
    # ══════════════════════════════════════════════
    {
      key = "<Esc>";
      mode = "n";
      action = "<cmd>nohlsearch<CR>";
      options = {
        desc = "Clear search highlight";
      };
    }
    {
      key = "<leader>z";
      mode = "n";
      action = "<cmd>set wrap!<CR>";
      options = {
        desc = "Toggle soft wrap";
      };
    }
    {
      key = "<C-Left>";
      mode = "n";
      action = "<C-o>";
      options = {
        desc = "Jump backward";
      };
    }
    {
      key = "<C-Right>";
      mode = "n";
      action = "<C-i>";
      options = {
        desc = "Jump forward";
      };
    }
    {
      key = "<C-l>";
      mode = "n";
      action = "<cmd>wa | LazyGit<CR>";
      options = {
        desc = "Write all + LazyGit";
      };
    }
  ];
}
