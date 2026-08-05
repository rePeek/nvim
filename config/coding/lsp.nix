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
        "gd" = "definition";
        "gr" = "references";
        "gt" = "type_definition";
        "gi" = "implementation";
        "gD" = "declaration";
        "K" = "hover";
        "<leader>ca" = "code_action";
        "<leader>rn" = "rename";
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

  # ── LSP Format (auto-format with LSP as fallback) ──
  plugins.lsp-format.enable = true;

  # ── LSP Signature ──
  plugins.lsp-signature = {
    enable = true;
  };

  # ── Additional LSP Keymaps ──
  keymaps = [
    {
      key = "gK";
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
