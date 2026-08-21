-- ══════════════════════════════════════════════
--  repeek.mode — Minimal Mode Indicator (Snacks.win)
--  Shows current Vim mode as a floating label
--  anchored to the top-right of the active window.
-- ══════════════════════════════════════════════

local M = {}

-- ── Defaults ──
local config = {
  enabled = true,
  win = {
    relative = "win",
    row = 0,
    col = -1,
    height = 1,
    border = "none",
    backdrop = false,
    focusable = false,
  },
}

-- ── State ──
local state = {
  win = nil,
  parent = nil,
}

-- ── Mode name lookup ──
local mode_names = {
  n = "NORMAL",
  no = "NORMAL",
  nov = "NORMAL",
  noV = "NORMAL",
  ["no\22"] = "NORMAL",
  niI = "NORMAL",
  niR = "NORMAL",
  niV = "NORMAL",
  nt = "NORMAL",
  ntT = "NORMAL",

  i = "INSERT",
  ic = "INSERT",
  ix = "INSERT",

  v = "VISUAL",
  vs = "VISUAL",
  V = "V-LINE",
  Vs = "V-LINE",
  ["\22"] = "V-BLOCK",
  ["\22s"] = "V-BLOCK",

  s = "SELECT",
  S = "S-LINE",
  ["\19"] = "S-BLOCK",

  R = "REPLACE",
  Rc = "REPLACE",
  Rx = "REPLACE",
  Rv = "V-REPLACE",
  Rvc = "V-REPLACE",
  Rvx = "V-REPLACE",

  c = "COMMAND",
  cv = "EX",
  ce = "EX",

  r = "PROMPT",
  rm = "MORE",
  ["r?"] = "CONFIRM",

  ["!"] = "SHELL",
  t = "TERMINAL",
}

local function mode_name()
  local mode = vim.api.nvim_get_mode().mode
  return mode_names[mode] or mode:upper()
end

-- ── Parent window ──
local function parent_win()
  local win = vim.api.nvim_get_current_win()
  -- skip floating windows
  local cfg = vim.api.nvim_win_get_config(win)
  if cfg.relative ~= "" then
    return nil
  end
  return win
end

-- ── Render ──
local function render()
  local parent = parent_win()

  if not parent then
    return
  end

  local text = " " .. mode_name() .. " "
  local width = vim.api.nvim_strwidth(text)

  -- create on first call
  if not state.win then
    state.parent = parent

    state.win = Snacks.win(vim.tbl_deep_extend("force", config.win, {
      win = parent,
      width = width,
      text = text,
    }))

    return
  end

  -- window became invalid
  if not state.win:valid() then
    state.win = nil
    state.parent = nil
    render()
    return
  end

  state.parent = parent

  -- re-anchor to current window (relative="win")
  state.win.opts.win = parent

  -- width may change between modes
  state.win.opts.width = width

  vim.api.nvim_buf_set_lines(state.win.buf, 0, -1, false, { text })

  state.win:update()
end

-- ── Public API ──

function M.refresh()
  if not config.enabled then
    return
  end
  vim.schedule(render)
end

function M.setup(opts)
  config = vim.tbl_deep_extend("force", config, opts or {})

  if not config.enabled then
    return
  end

  local group = vim.api.nvim_create_augroup("repeek_mode_indicator", { clear = true })

  vim.api.nvim_create_autocmd({
    "ModeChanged",
    "WinEnter",
    "BufEnter",
    "WinResized",
    "VimResized",
  }, {
    group = group,
    callback = M.refresh,
  })

  M.refresh()
end

return M
