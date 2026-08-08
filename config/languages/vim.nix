{ pkgs, ... }:
{
  # ══════════════════════════════════════════════
  #  Vim & Query Language Module
  # ══════════════════════════════════════════════

  plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
    diff
    query
    regex
    vim
    vimdoc
  ];
}
