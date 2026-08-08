{ pkgs, ... }:
{
  # ══════════════════════════════════════════════
  #  Shell Language Module
  #  Bash / Fish
  # ══════════════════════════════════════════════

  # ── Formatters ──
  plugins.conform-nvim.settings.formatters_by_ft = {
    sh = [ "shfmt" ];
    fish = [ "fish_indent" ];
  };

  # ── Treesitter Grammars ──
  plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
    bash
  ];
}
