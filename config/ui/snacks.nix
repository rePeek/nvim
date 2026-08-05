{
  # ══════════════════════════════════════════════
  #  Snacks.nvim — The Swiss Army Knife (LazyVim core)
  # ══════════════════════════════════════════════
  plugins.snacks = {
    enable = true;

    settings = {
      # ── Notifier ──
      notifier = {
        enabled = true;
        timeout = 3000;
      };

      # ── Big File Handling ──
      bigfile = {
        enabled = true;
      };

      # ── Quick File (fast startup) ──
      quickfile = {
        enabled = true;
      };

      # ── Indent Guides ──
      indent = {
        enabled = true;
      };

      # ── Input Popups ──
      input = {
        enabled = true;
      };

      # ── Scope Highlighting ──
      scope = {
        enabled = true;
      };

      # ── Smooth Scrolling ──
      scroll = {
        enabled = true;
      };

      # ── Words Under Cursor (highlight references) ──
      words = {
        enabled = true;
      };

      # ── Statuscolumn (we set it manually in options) ──
      statuscolumn = {
        enabled = false;
      };

      # ── Dashboard (disabled) ──
      dashboard = {
        enabled = false;
      };

      # ── Picker (LazyVim uses snacks.picker, replacing telescope) ──
      picker = {
        enabled = true;
      };

      # ── Explorer (LazyVim uses snacks.explorer, replacing neo-tree) ──
      explorer = {
        enabled = true;
      };
    };
  };

  # ══════════════════════════════════════════════
  #  Snacks Keymaps
  # ══════════════════════════════════════════════
  keymaps = [
    # ── Notification History ──
    {
      key = "<leader>n";
      mode = "n";
      action = {
        __raw = ''
          function()
            if Snacks.config.picker and Snacks.config.picker.enabled then
              Snacks.picker.notifications()
            else
              Snacks.notifier.show_history()
            end
          end
        '';
      };
      options = {
        desc = "Notification History";
      };
    }
    # ── Dismiss All Notifications ──
    {
      key = "<leader>un";
      mode = "n";
      action = {
        __raw = "function() Snacks.notifier.hide() end";
      };
      options = {
        desc = "Dismiss All Notifications";
      };
    }

    # ── Snacks Picker (replaces Telescope) ──
    {
      key = "<leader>/";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.grep() end";
      };
      options = {
        desc = "Live grep";
      };
    }
    {
      key = "<leader> ";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.files() end";
      };
      options = {
        desc = "Find files";
      };
    }
    {
      key = "<leader>,";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.commands() end";
      };
      options = {
        desc = "Command palette";
      };
    }
    {
      key = "<leader>ff";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.files() end";
      };
      options = {
        desc = "Find files";
      };
    }
    {
      key = "<leader>fg";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.grep() end";
      };
      options = {
        desc = "Live grep";
      };
    }
    {
      key = "<leader>fb";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.buffers() end";
      };
      options = {
        desc = "Buffers";
      };
    }
    {
      key = "<leader>fh";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.help() end";
      };
      options = {
        desc = "Help tags";
      };
    }
    {
      key = "<leader>fr";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.recent() end";
      };
      options = {
        desc = "Recent files";
      };
    }
    {
      key = "<leader>fs";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.grep_word() end";
      };
      options = {
        desc = "Grep string under cursor";
      };
    }
    {
      key = "<leader>fd";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.diagnostics() end";
      };
      options = {
        desc = "Diagnostics";
      };
    }
    {
      key = "<leader>fk";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.keymaps() end";
      };
      options = {
        desc = "Keymaps";
      };
    }
    {
      key = "<leader>fl";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.lines() end";
      };
      options = {
        desc = "Lines";
      };
    }

    # ── Git Pickers ──
    {
      key = "<leader>gf";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.git_files() end";
      };
      options = {
        desc = "Git files";
      };
    }
    {
      key = "<leader>gL";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.git_log() end";
      };
      options = {
        desc = "Git Log (cwd)";
      };
    }
    {
      key = "<leader>gl";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.git_log() end";
      };
      options = {
        desc = "Git Log";
      };
    }

    # ── Snacks Explorer (replaces Oil / Neo-tree) ──
    {
      key = "<leader>e";
      mode = "n";
      action = {
        __raw = "function() Snacks.explorer.open() end";
      };
      options = {
        desc = "Explorer";
      };
    }

    # ── Floating Terminal ──
    {
      key = "<leader>ft";
      mode = "n";
      action = {
        __raw = "function() Snacks.terminal() end";
      };
      options = {
        desc = "Terminal";
      };
    }
    {
      key = "<c-/>";
      mode = [
        "n"
        "t"
      ];
      action = {
        __raw = "function() Snacks.terminal.focus() end";
      };
      options = {
        desc = "Terminal (toggle)";
      };
    }

    # ── Lazygit (via Snacks) ──
    {
      key = "<leader>gg";
      mode = "n";
      action = {
        __raw = "function() Snacks.lazygit() end";
      };
      options = {
        desc = "Lazygit";
      };
    }

    # ── Git Browse ──
    {
      key = "<leader>gB";
      mode = [
        "n"
        "x"
      ];
      action = {
        __raw = "function() Snacks.gitbrowse() end";
      };
      options = {
        desc = "Git Browse (open)";
      };
    }

    # ── Scratch / Debug ──
    {
      key = "<leader>.";
      mode = "n";
      action = {
        __raw = "function() Snacks.scratch() end";
      };
      options = {
        desc = "Toggle Scratch Buffer";
      };
    }
  ];
}
