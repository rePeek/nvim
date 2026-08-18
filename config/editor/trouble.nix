{
  # ══════════════════════════════════════════════
  #  Trouble.nvim — Diagnostics & Symbols (from LazyVim)
  # ══════════════════════════════════════════════
  plugins.trouble = {
    enable = true;
    settings = {
      config = {
        __raw = ''
          function(opts)
            local cols = vim.o.columns
            local lines = vim.o.lines
            local wide = cols >= 160

            -- Override focus for all modes (including symbols' default false)
            opts.focus = true

            -- Responsive float window layout
            opts.win = {
              type = "float",
              relative = "editor",
              border = "rounded",
              position = wide and { 0.5, 1.0 } or { 1.0, 0.5 },
              size = wide
                and { width = 0.35, height = 0.9 }
                or { width = 0.95, height = 0.32 },
            }
          end
        '';
      };
    };
  };

  keymaps = [
    {
      key = "<leader>xx";
      mode = "n";
      action = {
        __raw = ''
          function()
            local trouble = require("trouble")
            local mode = "diagnostics"
            if trouble.is_open({ mode = mode }) then
              if vim.bo.filetype == "trouble" then
                trouble.close({ mode = mode })
              else
                trouble.focus({ mode = mode })
              end
            else
              trouble.open(mode)
            end
          end
        '';
      };
      options = {
        desc = "Diagnostics (Trouble)";
      };
    }
    {
      key = "<leader>xX";
      mode = "n";
      action = {
        __raw = ''
          function()
            local trouble = require("trouble")
            local mode = "diagnostics"
            if trouble.is_open({ mode = mode }) then
              if vim.bo.filetype == "trouble" then
                trouble.close({ mode = mode })
              else
                trouble.focus({ mode = mode })
              end
            else
              trouble.open({ mode = mode, filter = { buf = 0 } })
            end
          end
        '';
      };
      options = {
        desc = "Buffer Diagnostics (Trouble)";
      };
    }
    {
      key = "<leader>xs";
      mode = "n";
      action = {
        __raw = ''
          function()
            local trouble = require("trouble")
            local mode = "symbols"
            if trouble.is_open({ mode = mode }) then
              if vim.bo.filetype == "trouble" then
                trouble.close({ mode = mode })
              else
                trouble.focus({ mode = mode })
              end
            else
              trouble.open(mode)
            end
          end
        '';
      };
      options = {
        desc = "Symbols (Trouble)";
      };
    }
    {
      key = "<leader>xS";
      mode = "n";
      action = {
        __raw = ''
          function()
            local trouble = require("trouble")
            local mode = "lsp"
            if trouble.is_open({ mode = mode }) then
              if vim.bo.filetype == "trouble" then
                trouble.close({ mode = mode })
              else
                trouble.focus({ mode = mode })
              end
            else
              trouble.open(mode)
            end
          end
        '';
      };
      options = {
        desc = "LSP references/definitions (Trouble)";
      };
    }
    {
      key = "<leader>xL";
      mode = "n";
      action = {
        __raw = ''
          function()
            local trouble = require("trouble")
            local mode = "loclist"
            if trouble.is_open({ mode = mode }) then
              if vim.bo.filetype == "trouble" then
                trouble.close({ mode = mode })
              else
                trouble.focus({ mode = mode })
              end
            else
              trouble.open(mode)
            end
          end
        '';
      };
      options = {
        desc = "Location List (Trouble)";
      };
    }
    {
      key = "<leader>xQ";
      mode = "n";
      action = {
        __raw = ''
          function()
            local trouble = require("trouble")
            local mode = "qflist"
            if trouble.is_open({ mode = mode }) then
              if vim.bo.filetype == "trouble" then
                trouble.close({ mode = mode })
              else
                trouble.focus({ mode = mode })
              end
            else
              trouble.open(mode)
            end
          end
        '';
      };
      options = {
        desc = "Quickfix List (Trouble)";
      };
    }
    {
      key = "<leader>xq";
      mode = "n";
      action = {
        __raw = ''
          function()
            local trouble = require("trouble")
            local mode = "qflist"
            if trouble.is_open({ mode = mode }) then
              if vim.bo.filetype == "trouble" then
                trouble.close({ mode = mode })
              else
                trouble.focus({ mode = mode })
              end
            else
              trouble.open(mode)
            end
          end
        '';
      };
      options = {
        desc = "Quickfix List (Trouble)";
      };
    }
    {
      key = "<leader>xl";
      mode = "n";
      action = {
        __raw = ''
          function()
            local trouble = require("trouble")
            local mode = "loclist"
            if trouble.is_open({ mode = mode }) then
              if vim.bo.filetype == "trouble" then
                trouble.close({ mode = mode })
              else
                trouble.focus({ mode = mode })
              end
            else
              trouble.open(mode)
            end
          end
        '';
      };
      options = {
        desc = "Location List (Trouble)";
      };
    }
  ];
}
