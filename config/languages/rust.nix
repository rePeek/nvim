{ pkgs, ... }:
{
  # ══════════════════════════════════════════════
  #  Rust Language Module
  #  LSP: rust-analyzer  |  Formatter: rustfmt
  # ══════════════════════════════════════════════

  # ── LSP Server ──
  plugins.lsp.servers.rust_analyzer = {
    enable = true;
    installCargo = false;
    installRustc = false;
  };

  # ── Formatter ──
  plugins.conform-nvim.settings.formatters_by_ft.rust = [ "rustfmt" ];

  # ── Treesitter Grammar ──
  plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
    rust
  ];
}
