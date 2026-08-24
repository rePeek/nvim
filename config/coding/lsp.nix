{
  # ══════════════════════════════════════════════
  #  LSP Framework (Nix-native, no Mason)
  #  Language-specific servers go in languages/*.nix
  # ══════════════════════════════════════════════
  plugins.lsp = {
    enable = true;

    # ── LSP Keymaps (LazyVim-style) ──
    keymaps = {
      lspBuf = {
        "K" = "hover";
        "<leader>ca" = "code_action";
      };
      diagnostic = {
        "<leader>cd" = "open_float";
        "[d" = "goto_prev";
        "]d" = "goto_next";
      };
    };

    # ── Inlay Hints (from LazyVim lsp) ──
    inlayHints = true;
  };

  # ── Incremental Rename (live preview) ──
  plugins.inc-rename = {
    enable = true;
    settings = {
      cmd_name = "IncRename";
      hl_group = "Substitute";
      preview_empty_name = false;
      show_message = true;
    };
  };

  # ── Additional LSP Keymaps ──
  keymaps = [
    {
      key = "<leader>ck";
      mode = "n";
      action = {
        __raw = "function() vim.lsp.buf.signature_help() end";
      };
      options = {
        desc = "Signature Help";
      };
    }
    {
      key = "<C-k>";
      mode = "i";
      action = {
        __raw = "function() vim.lsp.buf.signature_help() end";
      };
      options = {
        desc = "Signature Help (insert)";
      };
    }
    {
      key = "<leader>cr";
      mode = "n";
      action = {
        __raw = "function() vim.cmd('IncRename ' .. vim.fn.expand('<cword>')) end";
      };
      options = {
        desc = "Rename";
      };
    }
    {
      key = "<leader>cA";
      mode = "n";
      action = {
        __raw = ''
          function()
            vim.lsp.buf.code_action({
              apply = true,
              context = { only = { "source" }, diagnostics = {} }
            })
          end
        '';
      };
      options = {
        desc = "Source Action";
      };
    }
  ];
}
