{
  # ══════════════════════════════════════════════
  #  Conform.nvim — Formatter Framework
  #  Language-specific formatters go in languages/*.nix
  # ══════════════════════════════════════════════
  plugins.conform-nvim = {
    enable = true;
    settings = {
      default_format_opts = {
        timeout_ms = 3000;
        async = false;
        quiet = false;
        lsp_format = "fallback";
      };
      # Format JSON before writing so compact exports stay readable.
      format_on_save = {
        __raw = ''
          function(bufnr)
            if vim.bo[bufnr].filetype == "json" then
              return { timeout_ms = 3000, lsp_format = "fallback" }
            end
          end
        '';
      };
      formatters = {
        injected = {
          options = {
            ignore_errors = true;
          };
        };
      };
    };
  };

  # ── Format keymaps ──
  keymaps = [
    {
      key = "<leader>cf";
      mode = [
        "n"
        "x"
      ];
      action = {
        __raw = ''
          function()
            require("conform").format({ force = true, async = false, timeout_ms = 3000 })
          end
        '';
      };
      options = {
        desc = "Format";
      };
    }
    {
      key = "<leader>cF";
      mode = [
        "n"
        "x"
      ];
      action = {
        __raw = ''
          function()
            require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
          end
        '';
      };
      options = {
        desc = "Format Injected Langs";
      };
    }
  ];
}
