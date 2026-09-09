{
  # ══════════════════════════════════════════════
  #  Treesitter — Base Framework
  #  Language-specific grammars go in languages/*.nix
  # ══════════════════════════════════════════════
  plugins.treesitter = {
    enable = true;

    # Nixvim's native setup starts parsers synchronously during FileType. With
    # Nix-managed start packages, its parser/query lookup scans the whole
    # packpath and delays the first screen noticeably. Grammars remain managed
    # by Nix; their activation is deferred below instead.
    highlight.enable = false;
    indent.enable = false;
  };

  # Nixvim currently has no native option to defer its Tree-sitter FileType
  # handler. Start it just after the first UI frame, then immediately for all
  # later buffers. This preserves highlighting and Tree-sitter indentation.
  extraConfigLua = ''
    local function nixvim_start_treesitter(buf)
      if not vim.api.nvim_buf_is_valid(buf)
        or vim.b[buf].nixvim_treesitter_started
        or vim.bo[buf].buftype ~= "" then
        return
      end

      local filetype = vim.bo[buf].filetype
      local lang = vim.treesitter.language.get_lang(filetype)
      if not lang or not vim.treesitter.language.add(lang) then
        return
      end

      vim.b[buf].nixvim_treesitter_started = true

      if vim.treesitter.query.get(lang, "highlights") then
        vim.treesitter.start(buf, lang)
        vim.b[buf].undo_ftplugin = (vim.b[buf].undo_ftplugin and vim.b[buf].undo_ftplugin .. " | " or "")
          .. ("call v:lua.vim.treesitter.stop(%d)"):format(buf)
      end

      if vim.treesitter.query.get(lang, "indents") then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        vim.b[buf].undo_ftplugin = (vim.b[buf].undo_ftplugin and vim.b[buf].undo_ftplugin .. " | " or "")
          .. "setlocal indentexpr<"
      end
    end

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("nixvim_deferred_treesitter", { clear = true }),
      pattern = "*",
      callback = function(args)
        if vim.v.vim_did_enter == 1 then
          nixvim_start_treesitter(args.buf)
        end
      end,
    })

    vim.api.nvim_create_autocmd("VimEnter", {
      group = "nixvim_deferred_treesitter",
      once = true,
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
        vim.defer_fn(function()
          nixvim_start_treesitter(buf)
        end, 10)
      end,
    })
  '';

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
