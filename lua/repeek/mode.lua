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

-- ── Highlight group map ──
local hl_map = {
  normal   = "RePeekModeNormal",
  insert   = "RePeekModeInsert",
  visual   = "RePeekModeVisual",
  replace  = "RePeekModeReplace",
  command  = "RePeekModeCommand",
  terminal = "RePeekModeTerminal",
}

-- ── Fallback palette ──
local fallback = {
  normal   = { fg = "#1e2030", bg = "#7cafc2" },
  insert   = { fg = "#1e2030", bg = "#a3be8c" },
  visual   = { fg = "#1e2030", bg = "#c4a7e7" },
  replace  = { fg = "#1e2030", bg = "#ed8796" },
  command  = { fg = "#1e2030", bg = "#e5c890" },
  terminal = { fg = "#1e2030", bg = "#89b482" },
}

-- ── Mode info: label + theme key ──
local function mode_info()
  local mode = vim.api.nvim_get_mode().mode

  -- Normal (n, no, nov, noV, niI, niR, niV, nt, ntT, …)
  if mode:sub(1, 1) == "n" then
    return "NORMAL", "normal"
  elseif mode:sub(1, 1) == "i" then
    return "INSERT", "insert"
  elseif mode == "v" or mode == "vs" then
    return "VISUAL", "visual"
  elseif mode == "V" or mode == "Vs" then
    return "V-LINE", "visual"
  elseif mode == "\22" or mode == "\22s" then
    return "V-BLOCK", "visual"
  elseif mode == "s" or mode == "S" or mode == "\19" then
    return "SELECT", "visual"
  elseif mode:sub(1, 1) == "R" then
    return "REPLACE", "replace"
  elseif mode:sub(1, 1) == "c" then
    return "COMMAND", "command"
  elseif mode:sub(1, 1) == "t" then
    return "TERMINAL", "terminal"
  end

  return mode:upper(), "normal"
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

-- ── Build RePeekMode* highlights from colorscheme lualine adapter ──
local function setup_mode_highlights()
  local colorscheme = vim.g.colors_name

  local theme_ok, theme = false, nil
  if colorscheme then
    theme_ok, theme = pcall(require, "lualine.themes." .. colorscheme)
  end

  for mode_key, hl_name in pairs(hl_map) do
    local color

    -- try colorscheme's lualine adapter first
    if theme_ok and theme and theme[mode_key] and theme[mode_key].a then
      color = theme[mode_key].a
    end

    if color then
      vim.api.nvim_set_hl(0, hl_name, {
        fg = color.fg,
        bg = color.bg,
        bold = color.gui == "bold",
      })
    else
      -- fallback
      local fb = fallback[mode_key]
      vim.api.nvim_set_hl(0, hl_name, {
        fg = fb.fg,
        bg = fb.bg,
        bold = true,
      })
    end
  end
end

-- ── Render ──
local function render()
  local parent = parent_win()

  if not parent then
    return
  end

  local label, theme_mode = mode_info()
  local text = " " .. label .. " "
  local width = vim.api.nvim_strwidth(text)
  local win_width = vim.api.nvim_win_get_width(parent)
  local col = win_width - width
  local winhighlight = "Normal:" .. hl_map[theme_mode]

  -- create on first call
  if not state.win then
    state.parent = parent

    state.win = Snacks.win(vim.tbl_deep_extend("force", config.win, {
      win = parent,
      col = col,
      width = width,
      text = text,
      wo = {
        winhighlight = winhighlight,
      },
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
  state.win.opts.col = col
  state.win.opts.width = width
  state.win.opts.wo = vim.tbl_deep_extend("force", state.win.opts.wo or {}, {
    winhighlight = winhighlight,
  })

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

  -- this plugin owns the mode/status UI
  vim.opt.laststatus = 0
  vim.opt.showmode = false
  vim.opt.ruler = false

  if not config.enabled then
    return
  end

  setup_mode_highlights()

  local group = vim.api.nvim_create_augroup("repeek_mode_indicator", { clear = true })

  -- refresh badge on mode/window/buffer changes
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

  -- rebuild highlights when colorscheme changes
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = group,
    callback = function()
      vim.schedule(setup_mode_highlights)
      vim.schedule(M.refresh)
    end,
  })

  M.refresh()
end

return M
