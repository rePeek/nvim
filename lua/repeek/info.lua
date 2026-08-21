-- ══════════════════════════════════════════════
--  repeek.info — Current buffer information HUD
-- ══════════════════════════════════════════════

local M = {}

local config = {
  enabled = true,
  key = "<leader>i",
  win = {
    position = "float",
    relative = "editor",
    row = 2,
    width = 60,
    border = true,
    title = " Info ",
    title_pos = "center",
    backdrop = false,
    focusable = false,
    enter = false,
    noautocmd = true,
    wo = {
      winhighlight = "NormalFloat:SnacksInputNormal,FloatBorder:SnacksInputBorder,FloatTitle:SnacksInputTitle",
      cursorline = false,
    },
  },
}

local state = {
  win = nil,
}

local ns = vim.api.nvim_create_namespace("repeek.info")

local function setup_highlights()
  local groups = {
    RePeekInfoPrimary = "Normal",
    RePeekInfoSecondary = "Comment",
    RePeekInfoLabel = "Normal",
    RePeekInfoBranchIcon = "DiagnosticInfo",
    RePeekInfoActive = "DiagnosticOk",
    RePeekInfoInactive = "Comment",
    RePeekInfoAdded = "GitSignsAdd",
    RePeekInfoChanged = "GitSignsChange",
    RePeekInfoRemoved = "GitSignsDelete",
    RePeekInfoAhead = "DiagnosticOk",
    RePeekInfoBehind = "DiagnosticWarn",
  }

  for name, link in pairs(groups) do
    vim.api.nvim_set_hl(0, name, { link = link, default = true })
  end

  local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
  vim.api.nvim_set_hl(0, "RePeekInfoPath", {
    fg = normal.fg,
    bold = true,
  })
end

local function buffer_directory(buf)
  local name = vim.api.nvim_buf_get_name(buf)
  if name == "" then
    return vim.fn.getcwd()
  end
  return vim.fs.dirname(name)
end

local function git_sync_status(directory)
  local result = vim.system({
    "git",
    "-C",
    directory,
    "rev-list",
    "--left-right",
    "--count",
    "HEAD...@{upstream}",
  }, { text = true }):wait()

  if result.code ~= 0 then
    return 0, 0
  end

  local ahead, behind = (result.stdout or ""):match("^(%d+)%s+(%d+)")
  return tonumber(ahead) or 0, tonumber(behind) or 0
end

local function git_status(buf)
  local head = vim.b[buf].gitsigns_head
  local status = vim.b[buf].gitsigns_status_dict
  local directory = buffer_directory(buf)

  if type(head) ~= "string" or head == "" then
    local result = vim.system({
      "git",
      "-C",
      directory,
      "branch",
      "--show-current",
    }, { text = true }):wait()

    if result.code ~= 0 then
      return nil
    end

    head = vim.trim(result.stdout or "")
    head = head ~= "" and head or "detached HEAD"
  end

  status = type(status) == "table" and status or {}
  local ahead = tonumber(status.ahead)
  local behind = tonumber(status.behind)
  if ahead == nil or behind == nil then
    ahead, behind = git_sync_status(directory)
  end

  return {
    branch = head,
    added = tonumber(status.added) or 0,
    changed = tonumber(status.changed) or 0,
    removed = tonumber(status.removed) or 0,
    ahead = ahead,
    behind = behind,
  }
end

local function lsp_status(buf)
  local clients = vim.lsp.get_clients({ bufnr = buf })
  if #clients == 0 then
    return "inactive", false
  end

  local names = {}
  for _, client in ipairs(clients) do
    names[#names + 1] = client.name
  end
  table.sort(names)

  return table.concat(names, ", "), true
end

local function dap_status()
  local ok, dap = pcall(require, "dap")
  if not ok then
    return "inactive", false
  end

  local session = dap.session()
  if not session then
    return "inactive", false
  end

  return session.stopped_thread_id and "stopped" or "running", true
end

local function formatter_status(buf)
  local ok, conform = pcall(require, "conform")
  if not ok then
    return "—", false
  end

  local listed, formatters, use_lsp = pcall(conform.list_formatters_to_run, buf)
  if not listed then
    return "—", false
  end

  local names = {}
  local seen = {}
  for _, formatter in ipairs(formatters) do
    local name = formatter.name:gsub("_", "-")
    names[#names + 1] = name
    seen[name] = true
  end
  if use_lsp then
    local method = vim.lsp.protocol.Methods.textDocument_formatting or "textDocument/formatting"
    local clients = vim.lsp.get_clients({ bufnr = buf, method = method })
    for _, client in ipairs(clients) do
      if not seen[client.name] then
        names[#names + 1] = client.name
        seen[client.name] = true
      end
    end
  end

  return #names > 0 and table.concat(names, ", ") or "—", #names > 0
end

local function truncate(text, max_width)
  if vim.api.nvim_strwidth(text) <= max_width then
    return text
  end

  local chars = vim.fn.strchars(text)
  while chars > 0 do
    local shortened = vim.fn.strcharpart(text, 0, chars)
    if vim.api.nvim_strwidth(shortened .. "…") <= max_width then
      return shortened .. "…"
    end
    chars = chars - 1
  end

  return "…"
end

local function truncate_middle(text, max_width)
  if vim.api.nvim_strwidth(text) <= max_width then
    return text
  end

  local chars = vim.fn.strchars(text)
  local left_chars = math.ceil((chars - 1) / 2)
  local right_chars = math.floor((chars - 1) / 2)

  while left_chars > 0 or right_chars > 0 do
    local left = vim.fn.strcharpart(text, 0, left_chars)
    local right = vim.fn.strcharpart(text, chars - right_chars, right_chars)
    if vim.api.nvim_strwidth(left .. "…" .. right) <= max_width then
      return left .. "…" .. right
    end
    if left_chars > right_chars then
      left_chars = left_chars - 1
    else
      right_chars = right_chars - 1
    end
  end

  return "…"
end

local function build_line(parts)
  local text = ""
  local highlights = {}

  for _, part in ipairs(parts) do
    local start_col = #text
    text = text .. part[1]
    if part[2] and part[1] ~= "" then
      highlights[#highlights + 1] = {
        start_col = start_col,
        end_col = #text,
        hl_group = part[2],
      }
    end
  end

  return text, highlights
end

local function centered_line(parts, width)
  local content_width = 0
  for _, part in ipairs(parts) do
    content_width = content_width + vim.api.nvim_strwidth(part[1])
  end

  local left = math.max(0, math.floor((width - content_width) / 2))
  local right = math.max(0, width - content_width - left)
  table.insert(parts, 1, { string.rep(" ", left) })
  parts[#parts + 1] = { string.rep(" ", right) }
  return build_line(parts)
end

local function lines(buf, width)
  local name = vim.api.nvim_buf_get_name(buf)
  local path = name ~= "" and vim.fs.normalize(vim.fn.fnamemodify(name, ":p")) or "Untitled"
  local git = git_status(buf)
  local lsp, lsp_active = lsp_status(buf)
  local dap, dap_active = dap_status()
  local formatter, formatter_active = formatter_status(buf)

  path = truncate_middle(path, width - 4)

  local git_parts = {}
  if git then
    local status_width = 0
    local status_values = {
      { " +" .. git.added, "RePeekInfoAdded", git.added },
      { " ~" .. git.changed, "RePeekInfoChanged", git.changed },
      { " -" .. git.removed, "RePeekInfoRemoved", git.removed },
      { " ↑" .. git.ahead, "RePeekInfoAhead", git.ahead },
      { " ↓" .. git.behind, "RePeekInfoBehind", git.behind },
    }
    for _, item in ipairs(status_values) do
      if item[3] > 0 then
        status_width = status_width + vim.api.nvim_strwidth(item[1])
      end
    end

    local branch = truncate(git.branch, math.max(8, width - status_width - 6))
    git_parts = {
      { "󰊢 ", "RePeekInfoBranchIcon" },
      { branch, "RePeekInfoSecondary" },
    }
    for _, item in ipairs(status_values) do
      if item[3] > 0 then
        git_parts[#git_parts + 1] = { item[1], item[2] }
      end
    end
  end

  local dap_icon = dap_active and "●" or "○"
  local lsp_icon = lsp_active and "●" or "○"
  local formatter_icon = formatter_active and "●" or "○"
  local lsp_display = lsp_active and truncate(lsp, 12) or "off"
  local dap_display = dap_active and dap or "off"
  local formatter_display = formatter_active and formatter or "off"
  local lsp_parts_width = vim.api.nvim_strwidth("LSP " .. lsp_icon .. " " .. lsp_display)
  local dap_parts_width = vim.api.nvim_strwidth("DAP " .. dap_icon .. " " .. dap_display)
  local status_gap = "   "
  local formatter_prefix = "Formatter " .. formatter_icon .. " "
  local formatter_prefix_width = vim.api.nvim_strwidth(formatter_prefix)
  local formatter_width = width - 4 - lsp_parts_width - dap_parts_width - (2 * #status_gap) - formatter_prefix_width
  formatter_display = truncate(formatter_display, math.max(8, formatter_width))

  local content = {}
  local highlights = {}

  content[1], highlights[1] = centered_line({ { path, "RePeekInfoPath" } }, width)
  content[2], highlights[2] = centered_line(git_parts, width)
  content[3], highlights[3] = "", {}
  content[4], highlights[4] = centered_line({
    { "LSP", "RePeekInfoLabel" },
    { " " },
    { lsp_icon, lsp_active and "RePeekInfoActive" or "RePeekInfoInactive" },
    { " " },
    { lsp_display, lsp_active and "RePeekInfoPrimary" or "RePeekInfoSecondary" },
    { status_gap },
    { "DAP", "RePeekInfoLabel" },
    { " " },
    { dap_icon, dap_active and "RePeekInfoActive" or "RePeekInfoInactive" },
    { " " },
    { dap_display, dap_active and "RePeekInfoPrimary" or "RePeekInfoSecondary" },
    { status_gap },
    { "Formatter", "RePeekInfoLabel" },
    { " " },
    { formatter_icon, formatter_active and "RePeekInfoActive" or "RePeekInfoInactive" },
    { " " },
    { formatter_display, formatter_active and "RePeekInfoPrimary" or "RePeekInfoSecondary" },
  }, width)

  return content, highlights
end

local function apply_highlights(buf, highlights)
  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

  for line, spans in ipairs(highlights) do
    for _, span in ipairs(spans) do
      vim.api.nvim_buf_set_extmark(buf, ns, line - 1, span.start_col, {
        end_col = span.end_col,
        hl_group = span.hl_group,
      })
    end
  end
end

function M.close()
  if state.win and state.win:valid() then
    state.win:close()
  end

  state.win = nil
end

function M.open()
  if not config.enabled then
    return
  end

  local buf = vim.api.nvim_get_current_buf()
  local width = config.win.width
  local content, highlights = lines(buf, width)

  state.win = Snacks.win(vim.tbl_deep_extend("force", {}, config.win, {
    height = #content,
    text = content,
    on_close = function()
      state.win = nil
    end,
  }))

  apply_highlights(state.win.buf, highlights)
end

function M.toggle()
  if state.win and state.win:valid() then
    M.close()
    return
  end

  M.open()
end

function M.setup(opts)
  config = vim.tbl_deep_extend("force", config, opts or {})

  if not config.enabled then
    M.close()
    return
  end

  setup_highlights()

  local group = vim.api.nvim_create_augroup("repeek_info", { clear = true })
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = group,
    callback = setup_highlights,
  })

  if config.key then
    vim.keymap.set("n", config.key, M.toggle, {
      desc = "Buffer Info",
    })
  end
end

return M
