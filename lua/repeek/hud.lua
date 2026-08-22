-- ══════════════════════════════════════════════
--  repeek.hud — Head-Up Display
--  Mode indicator + editor UI policy.
--
--  Providers:
--    • mode indicator (Snacks.win floating badge)
--    • split separators (fillchars.vert / stl / stlnc)
--    • statusline / showmode / ruler suppression
-- ══════════════════════════════════════════════

local M = {}

-- ── Defaults ──
local config = {
  enabled = true,

  editor_ui = {
    hide_statusline = true,
    separator = "─",
    vertical_separator = "│",
  },

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
}
local pending = false

-- ── Highlight group map ──
local hl_map = {
  normal = "RePeekModeNormal",
  insert = "RePeekModeInsert",
  visual = "RePeekModeVisual",
  replace = "RePeekModeReplace",
  command = "RePeekModeCommand",
  terminal = "RePeekModeTerminal",
}

-- ── Fallback palette ──
local fallback = {
  normal = { fg = "#1e2030", bg = "#7cafc2" },
  insert = { fg = "#1e2030", bg = "#a3be8c" },
  visual = { fg = "#1e2030", bg = "#c4a7e7" },
  replace = { fg = "#1e2030", bg = "#ed8796" },
  command = { fg = "#1e2030", bg = "#e5c890" },
  terminal = { fg = "#1e2030", bg = "#89b482" },
}

-- ── Mode info: label + theme key ──
local function mode_info()
  local mode = vim.api.nvim_get_mode().mode

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
  local cfg = vim.api.nvim_win_get_config(win)
  if cfg.relative ~= "" then
    return nil
  end
  return win
end

-- ── Editor UI policy ──
local function setup_editor_ui()
  local ui = config.editor_ui

  if ui.hide_statusline then
    vim.o.laststatus = 0
    vim.o.showmode = false
    vim.o.ruler = false

    -- space prevents Neovim from rendering filename in splits
    vim.o.statusline = " "
  end

  -- merge into existing fillchars, never overwrite
  local fillchars = vim.opt.fillchars:get()
  fillchars.vert = ui.vertical_separator
  fillchars.stl = ui.separator
  fillchars.stlnc = ui.separator
  vim.opt.fillchars = fillchars
end

-- ── Split separator highlights ──
local function setup_highlights()
  local normal = vim.api.nvim_get_hl(0, {
    name = "Normal",
    link = false,
  })

  -- use Normal fg so all dividers match the theme's text color
  vim.api.nvim_set_hl(0, "WinSeparator", {
    fg = normal.fg,
    bg = normal.bg,
  })

  vim.api.nvim_set_hl(0, "StatusLine", { link = "WinSeparator" })
  vim.api.nvim_set_hl(0, "StatusLineNC", { link = "WinSeparator" })
end

-- ── Mode badge highlights ──
local function setup_mode_highlights()
  for mode_key, hl_name in pairs(hl_map) do
    local color = fallback[mode_key]
    vim.api.nvim_set_hl(0, hl_name, {
      fg = color.fg,
      bg = color.bg,
      bold = true,
    })
  end
end

local function close_badge()
  if state.win and state.win:valid() then
    state.win:close()
  end
  state.win = nil
end

-- ── Render mode badge ──
local function render()
  local parent = parent_win()

  if not parent then
    close_badge()
    return
  end

  local label, theme_mode = mode_info()
  local text = " " .. label .. " "
  local width = vim.api.nvim_strwidth(text)
  local win_width = vim.api.nvim_win_get_width(parent)

  if win_width < width then
    close_badge()
    return
  end

  local col = win_width - width
  local winhighlight = "Normal:" .. hl_map[theme_mode]

  -- discard an invalid handle before deciding whether to create
  if state.win and not state.win:valid() then
    state.win = nil
  end

  -- create on first call
  if not state.win then
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
  if pending or not config.enabled then
    return
  end

  pending = true
  vim.schedule(function()
    if not pending then
      return
    end

    pending = false
    if config.enabled then
      render()
    end
  end)
end

function M.close()
  pending = false
  close_badge()

  pcall(vim.api.nvim_del_augroup_by_name, "repeek_hud")
end

function M.setup(opts)
  config = vim.tbl_deep_extend("force", config, opts or {})

  if not config.enabled then
    M.close()
    return
  end

  setup_editor_ui()
  setup_highlights()
  setup_mode_highlights()

  local group = vim.api.nvim_create_augroup("repeek_hud", { clear = true })

  -- refresh badge on mode/window/buffer/resize changes
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

  -- colorscheme resets StatusLine/StatusLineNC, re-link them
  -- also rebuild mode badge highlights
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = group,
    callback = function()
      vim.schedule(setup_highlights)
      vim.schedule(setup_mode_highlights)
      vim.schedule(M.refresh)
    end,
  })

  M.refresh()
end

return M
