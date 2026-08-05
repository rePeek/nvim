{ pkgs, ... }:
{
  # ══════════════════════════════════════════════
  #  Web & Config Languages Module
  #  JSON / YAML / HTML / JS / TS / TOML / XML / Shell
  # ══════════════════════════════════════════════

  # ── Formatters ──
  plugins.conform-nvim.settings.formatters_by_ft = {
    json = [ "prettierd" ];
    yaml = [ "prettierd" ];
    sh = [ "shfmt" ];
    fish = [ "fish_indent" ];
  };

  # ── Treesitter Grammars ──
  plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
    html
    javascript
    jsdoc
    json
    toml
    typescript
    tsx
    yaml
    xml
  ];
}
