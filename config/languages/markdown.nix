{ pkgs, ... }:
{
  # ══════════════════════════════════════════════
  #  Markdown Language Module
  #  LSP: marksman  |  Formatter: prettierd
  # ══════════════════════════════════════════════

  # ── LSP Server ──
  plugins.lsp.servers.marksman = {
    enable = true;
  };

  # ── Formatter ──
  plugins.conform-nvim.settings.formatters_by_ft = {
    markdown = [ "prettierd" ];
  };

  # ── Treesitter Grammar ──
  plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
    markdown
    markdown_inline
  ];
}
