{
  # ══════════════════════════════════════════════
  #  Leader
  # ══════════════════════════════════════════════
  globals = {
    mapleader = " ";
    maplocalleader = "\\";
    # Snacks animations
    snacks_animate = true;
  };

  # ══════════════════════════════════════════════
  #  Editor Options (LazyVim-inspired)
  # ══════════════════════════════════════════════
  opts = {
    # ── Line Numbers ──
    number = true;
    relativenumber = false;

    # ── Indentation ──
    shiftwidth = 2;
    tabstop = 2;
    softtabstop = 2;
    expandtab = true;
    smartindent = true;
    shiftround = true;

    # ── Clipboard ──
    clipboard = "unnamedplus";

    # ── UI ──
    signcolumn = "yes";
    cursorline = true;
    guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20";
    scrolloff = 4;
    sidescrolloff = 8;
    showmode = false;
    ruler = false;
    pumblend = 10;
    pumheight = 10;
    termguicolors = true;
    laststatus = 3; # global statusline

    # ── Splits ──
    splitright = true;
    splitbelow = true;
    splitkeep = "screen";

    # ── Search ──
    ignorecase = true;
    smartcase = true;
    inccommand = "nosplit"; # preview incremental substitute
    grepformat = "%f:%l:%c:%m";
    grepprg = "rg --vimgrep";

    # ── Editing ──
    wrap = false;
    linebreak = true;
    breakindent = true;
    undofile = true;
    swapfile = false;
    undolevels = 10000;
    updatetime = 200;
    timeoutlen = 300; # faster which-key trigger
    mouse = "a";
    virtualedit = "block";
    jumpoptions = "view";

    # ── Completion ──
    completeopt = "menu,menuone,noselect";

    # ── Folds ──
    foldlevel = 99;
    foldmethod = "indent";

    # ── Format ──
    formatoptions = "jcroqlnt";

    # ── Conceal ──
    conceallevel = 2;

    # ── Wildmode ──
    wildmode = "longest:full,full";

    # ── Misc ──
    autowrite = true;
    confirm = true;
    exrc = true;
    sessionoptions = [
      "buffers"
      "curdir"
      "tabpages"
      "winsize"
      "help"
      "globals"
      "skiprtp"
      "folds"
    ];
    winminwidth = 5;

    # ── Fill chars ──
    fillchars = {
      foldopen = "";
      foldclose = "";
      fold = " ";
      foldsep = " ";
      diff = "╱";
      eob = " ";
    };

    # ── List chars (visible whitespace) ──
    list = true;
  };

  # ══════════════════════════════════════════════
  #  Extra Lua Config
  # ══════════════════════════════════════════════
  extraConfigLua = ''
    -- OSC 52 clipboard for remote/SSH sessions
    if vim.env.SSH_CONNECTION then
      vim.opt.clipboard = ""
      vim.g.clipboard = {
        name = 'OSC 52',
        copy = {
          ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
          ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
        },
        paste = {
          ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
          ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
        },
      }
    end

    -- Diagnostic Styling
    vim.diagnostic.config({
      underline = true,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
      },
      signs = true,
      severity_sort = true,
      update_in_insert = false,
    })

    -- Fix markdown indentation
    vim.g.markdown_recommended_style = 0

    -- Disable built-in gr* global keymaps (Neovim 0.11+)
    -- These are GLOBAL mappings created at startup, not buffer-local
    for _, key in ipairs({ "gra", "gri", "grr", "grn", "grt", "grx" }) do
      pcall(vim.keymap.del, "n", key)
    end
    pcall(vim.keymap.del, "x", "gra")

    -- Shortmess tweaks
    vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
  '';
}
