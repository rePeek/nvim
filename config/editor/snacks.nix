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
        sources = {
          explorer = {
            win = {
              input.keys."<Esc>" = "close";
              list.keys."<Esc>" = "close";
            };
          };
        };
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
      key = "<leader>j";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.jumps() end";
      };
      options = {
        desc = "Jumplist";
      };
    }
    {
      key = "<leader>d";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.diagnostics() end";
      };
      options = {
        desc = "Diagnostics";
      };
    }

    # ── Goto (all via Snacks picker) ──
    {
      key = "gd";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.lsp_definitions() end";
      };
      options = {
        desc = "Goto Definition";
      };
    }
    {
      key = "gr";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.lsp_references() end";
      };
      options = {
        desc = "Goto References";
      };
    }
    {
      key = "gi";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.lsp_implementations() end";
      };
      options = {
        desc = "Goto Implementation";
      };
    }
    {
      key = "gt";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.lsp_type_definitions() end";
      };
      options = {
        desc = "Goto Type Definition";
      };
    }
    {
      key = "gD";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.lsp_declarations() end";
      };
      options = {
        desc = "Goto Declaration";
      };
    }
    {
      key = "ge";
      mode = "n";
      action = "G";
      options = {
        desc = "Goto End of File";
      };
    }
    {
      key = "<leader>ss";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.lsp_symbols() end";
      };
      options = {
        desc = "LSP Symbols";
      };
    }
    {
      key = "<leader>sS";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.lsp_workspace_symbols() end";
      };
      options = {
        desc = "LSP Workspace Symbols";
      };
    }
    {
      key = "<leader>st";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.treesitter() end";
      };
      options = {
        desc = "Treesitter Symbols";
      };
    }
    {
      key = "<leader>D";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.diagnostics_buffer() end";
      };
      options = {
        desc = "Buffer Diagnostics";
      };
    }
    {
      key = "<leader>l";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.loclist() end";
      };
      options = {
        desc = "Location List";
      };
    }
    {
      key = "<leader>x";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.qflist() end";
      };
      options = {
        desc = "Quickfix List";
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
    {
      key = "<leader>gH";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.git_stash() end";
      };
      options = {
        desc = "Git Stash";
      };
    }
    {
      key = "<leader>gA";
      mode = "n";
      action = {
        __raw = "function() Snacks.picker.git_status() end";
      };
      options = {
        desc = "Git Status";
      };
    }
    # ── Snacks Explorer ──
    {
      key = "<leader>e";
      mode = "n";
      action = {
        __raw = ''
          function()
            local explorer = Snacks.picker.get({ source = "explorer" })[1]
            if explorer then
              explorer:focus()
            else
              Snacks.explorer.open()
            end
          end
        '';
      };
      options = {
        desc = "Focus Explorer";
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
      key = "<leader>go";
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
