{
  # ══════════════════════════════════════════════
  #  Completion — blink.cmp (Rust-powered, replaces nvim-cmp)
  # ══════════════════════════════════════════════

  plugins.blink-cmp = {
    enable = true;
    # setupLspCapabilities is true by default, handles LSP capabilities automatically

    settings = {
      # ── Keymaps (unified: Tab=trigger, ↑↓=navigate, Enter=accept, Esc=cancel) ──
      keymap = {
        preset = "none";

        # ── Tab: trigger / snippet advance (NOT navigate) ──
        "<Tab>" = [
          "snippet_forward"
          {
            __raw = ''
              function(cmp)
                if cmp.is_visible() then
                  return true
                end

                return cmp.show()
              end
            '';
          }
          "fallback"
        ];
        "<S-Tab>" = [
          "snippet_backward"
          "fallback"
        ];

        # ── Arrow keys: navigate candidates ──
        "<Up>" = [
          "select_prev"
          "fallback"
        ];
        "<Down>" = [
          "select_next"
          "fallback"
        ];

        # ── Enter: accept  /  Esc: cancel ──
        "<CR>" = [
          "accept"
          "fallback"
        ];
        "<Esc>" = [
          "cancel"
          "fallback"
        ];

        # ── Documentation scroll ──
        "<C-b>" = [
          "scroll_documentation_up"
          "fallback"
        ];
        "<C-f>" = [
          "scroll_documentation_down"
          "fallback"
        ];
        "<C-Space>" = [
          "show"
          "show_documentation"
          "hide_documentation"
        ];
      };

      # ── Cmdline completion: same interaction model ──
      # (Tab=trigger, ↑↓=navigate, Enter=accept+execute, Esc=cancel)
      cmdline = {
        keymap = {
          preset = "none";
          "<Tab>" = [
            {
              __raw = ''
                function(cmp)
                  -- Passing providers makes Blink refresh even if the previous
                  -- command-line completion menu is still open.
                  return cmp.show_and_insert({ providers = { "buffer", "cmdline" } })
                end
              '';
            }
            "fallback"
          ];
          "<Up>" = [
            "select_prev"
            "fallback"
          ];
          "<Down>" = [
            "select_next"
            "fallback"
          ];
          "<CR>" = [
            "accept_and_enter"
            "fallback"
          ];
          "<Esc>" = [
            "cancel"
            "fallback"
          ];
        };
        sources = [
          "buffer"
          "cmdline"
        ];
        completion = {
          # Tab explicitly opens completion and previews its first candidate.
          # Esc cancels that preview; Enter confirms it and executes the command.
          menu = {
            auto_show = false;
          };
          ghost_text = {
            enabled = false;
          };
          list.selection = {
            # `show_and_insert` selects the first item explicitly, which applies
            # this preview; the default automatic selection remains disabled.
            preselect = false;
            auto_insert = true;
          };
        };
      };

      # ── Completion Menu ──
      completion = {
        menu = {
          # Tab explicitly starts completion; typing alone does not open a menu.
          auto_show = false;
          border = "rounded";
          scrollbar = false;
          winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None";
          draw = {
            columns = [
              { __unkeyed-1 = "kind_icon"; }
              {
                __unkeyed-1 = "label";
                __unkeyed-2 = "label_description";
                gap = 1;
              }
              { __unkeyed-1 = "kind"; }
            ];
          };
        };
        documentation = {
          auto_show = true;
          auto_show_delay_ms = 200;
          window = {
            border = "rounded";
            winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder";
          };
        };
        # A candidate is only written after the user selects and accepts it.
        list.selection = {
          preselect = false;
          auto_insert = false;
        };
      };

      # ── Signature Help ──
      signature = {
        enabled = true;
        window = {
          border = "rounded";
          winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder";
        };
      };

      # ── Sources ──
      sources.default = [
        "lsp"
        "path"
        "snippets"
        "buffer"
      ];

      # ── Snippet Engine (LuaSnip) ──
      snippets.preset = "luasnip";

      # ── Fuzzy Matching ──
      fuzzy.implementation = "prefer_rust_with_warning";

      # ── Appearance ──
      appearance = {
        use_nvim_cmp_as_default = true;
        kind_icons = {
          Copilot = "";
          Text = "󰉿";
          Method = "󰊕";
          Function = "󰊕";
          Constructor = "󰒓";
          Field = "󰜢";
          Variable = "󰆦";
          Property = "󰖷";
          EnumMember = "󰅟";
          Enum = "󰅟";
          Constant = "󰏿";
          Reference = "󰈝";
          Color = "󰏘";
          Struct = "󰙅";
          Class = "󱡠";
          Interface = "󱡠";
          Module = "󰅩";
          Value = "󰎠";
          Unit = "󰪚";
          Keyword = "󰌋";
          File = "󰈔";
          Folder = "󰉋";
          Snippet = "󱄽";
          Event = "󱐋";
          Operator = "󰪚";
          TypeParameter = "󰬛";
        };
      };
    };
  };

  # ── Snippet Engine ──
  plugins.luasnip.enable = true;

  # ── Friendly Snippets ──
  plugins.friendly-snippets.enable = true;
}
