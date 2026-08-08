{
  # ══════════════════════════════════════════════
  #  Treesitter — Base Framework
  #  Language-specific grammars go in languages/*.nix
  # ══════════════════════════════════════════════
  plugins.treesitter = {
    enable = true;

    settings = {
      highlight = {
        enable = true;
      };
      indent = {
        enable = true;
      };
    };

  };

  # ── Treesitter Context (sticky scope) ──
  plugins.treesitter-context = {
    enable = true;
    settings = {
      max_lines = 3;
      min_window_height = 0;
      line_numbers = true;
    };
  };

  # ── Treesitter Text Objects (from LazyVim treesitter.lua) ──
  plugins.treesitter-textobjects = {
    enable = true;
    settings = {
      move = {
        enable = true;
        set_jumps = true;
        goto_next_start = {
          "]f" = "@function.outer";
          "]c" = "@class.outer";
          "]a" = "@parameter.inner";
        };
        goto_next_end = {
          "]F" = "@function.outer";
          "]C" = "@class.outer";
          "]A" = "@parameter.inner";
        };
        goto_previous_start = {
          "[f" = "@function.outer";
          "[c" = "@class.outer";
          "[a" = "@parameter.inner";
        };
        goto_previous_end = {
          "[F" = "@function.outer";
          "[C" = "@class.outer";
          "[A" = "@parameter.inner";
        };
      };
    };
  };

  # ── Better comment syntax (from LazyVim coding.lua) ──
  plugins.ts-comments = {
    enable = true;
  };

  # ── Mini.ai — Enhanced Text Objects (from LazyVim coding.lua) ──
  plugins.mini-ai = {
    enable = true;
    settings = {
      n_lines = 500;
    };
  };

  # ── Mini.pairs — Auto Pairs (from LazyVim coding.lua) ──
  plugins.mini-pairs = {
    enable = true;
    settings = {
      modes = {
        insert = true;
        command = true;
        terminal = false;
      };
      skip_next = "[%w%%%'%[%\"%.%`%$]";
      skip_ts = [ "string" ];
      skip_unbalanced = true;
      markdown = true;
    };
  };

}
