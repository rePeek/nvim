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

local function buffer_directory(buf)
  local name = vim.api.nvim_buf_get_name(buf)
  if name == "" then
    return vim.fn.getcwd()
  end
  return vim.fs.dirname(name)
end

local function git_branch(buf)
  local head = vim.b[buf].gitsigns_head
  if type(head) == "string" and head ~= "" then
    return head
  end

  local result = vim.system({
    "git",
    "-C",
    buffer_directory(buf),
    "branch",
    "--show-current",
  }, { text = true }):wait()

  if result.code ~= 0 then
    return "not a repository"
  end

  local branch = vim.trim(result.stdout or "")
  return branch ~= "" and branch or "detached HEAD"
end

local function lsp_status(buf)
  local clients = vim.lsp.get_clients({ bufnr = buf })
  if #clients == 0 then
    return "inactive"
  end

  local names = {}
  for _, client in ipairs(clients) do
    names[#names + 1] = client.name
  end
  table.sort(names)

  return table.concat(names, ", ")
end

local function dap_status()
  local ok, dap = pcall(require, "dap")
  if not ok then
    return "inactive"
  end

  local session = dap.session()
  if not session then
    return "inactive"
  end

  return session.stopped_thread_id and "stopped" or "running"
end

local function lines(buf)
  local name = vim.api.nvim_buf_get_name(buf)
  local file = name ~= "" and vim.fs.basename(name) or "[No Name]"
  local encoding = vim.bo[buf].fileencoding
  local language = vim.bo[buf].filetype

  if encoding == "" then
    encoding = vim.o.encoding
  end
  if language == "" then
    language = "none"
  end

  local fields = {
    { "branch", git_branch(buf) },
    { "file", file },
    { encoding, language },
    { "LSP", lsp_status(buf) },
    { "DAP", dap_status() },
  }

  local content = {}
  for _, field in ipairs(fields) do
    content[#content + 1] = string.format(" %-8s %s ", field[1], field[2])
  end
  return content
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
  local content = lines(buf)

  state.win = Snacks.win(vim.tbl_deep_extend("force", {}, config.win, {
    height = #content,
    text = content,
    on_close = function()
      state.win = nil
    end,
  }))
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

  if config.key then
    vim.keymap.set("n", config.key, M.toggle, {
      desc = "Buffer Info",
    })
  end
end

return M
