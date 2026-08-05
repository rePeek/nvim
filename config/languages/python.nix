{ pkgs, ... }:
{
  # ══════════════════════════════════════════════
  #  Python Language Module
  #  LSP: pyright  |  Formatter: prettierd (via conform)
  # ══════════════════════════════════════════════

  # ── LSP Server ──
  plugins.lsp.servers.pyright = {
    enable = true;
  };

  # ── Treesitter Grammar ──
  plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
    python
  ];
}
