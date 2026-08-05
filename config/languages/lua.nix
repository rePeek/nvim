{
  # ══════════════════════════════════════════════
  #  Lua Language Module
  #  LSP: lua_ls  |  Formatter: stylua
  # ══════════════════════════════════════════════

  # ── LSP Server (LazyVim-inspired settings) ──
  plugins.lsp.servers.lua_ls = {
    enable = true;
    settings = {
      workspace = {
        checkThirdParty = false;
      };
      codeLens = {
        enable = true;
      };
      completion = {
        callSnippet = "Replace";
      };
      doc = {
        privateName = [ "^_" ];
      };
      hint = {
        enable = true;
        setType = false;
        paramType = true;
        paramName = "Disable";
        semicolon = "Disable";
        arrayIndex = "Disable";
      };
    };
  };

  # ── Formatter ──
  plugins.conform-nvim.settings.formatters_by_ft.lua = [ "stylua" ];
}
