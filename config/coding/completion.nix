{
  # ══════════════════════════════════════════════
  #  Completion — blink.cmp (Rust-powered, replaces nvim-cmp)
  # ══════════════════════════════════════════════

  plugins.blink-cmp = {
    enable = true;
    # setupLspCapabilities is true by default, handles LSP capabilities automatically

    settings = {
      # ── Keymaps (matching previous nvim-cmp bindings) ──
      keymap = {
        preset = "default";
        "<C-b>" = [ "scroll_documentation_up" "fallback" ];
        "<C-f>" = [ "scroll_documentation_down" "fallback" ];
        "<C-Space>" = [ "show" "show_documentation" "hide_documentation" ];
        "<CR>" = [ "accept" "fallback" ];
        "<Tab>" = [ "select_next" "fallback" ];
        "<S-Tab>" = [ "select_prev" "fallback" ];
        "<Up>" = [ "select_prev" "fallback" ];
        "<Down>" = [ "select_next" "fallback" ];
      };

      # ── Completion Menu ──
      completion = {
        menu = {
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
      sources.default = [ "lsp" "path" "snippets" "buffer" ];

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
