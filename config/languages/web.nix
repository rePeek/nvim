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
  };

  # ── Auto-close HTML/JSX Tags ──
  plugins.ts-autotag = {
    enable = true;
    lazyLoad.settings = {
      ft = [
        "html"
        "xml"
        "javascript"
        "javascriptreact"
        "typescript"
        "typescriptreact"
        "rust"
      ];
      # The FileType event has already started when lz-n loads the plugin.
      # Attach explicitly so the first matching buffer gets tag support too.
      after = {
        __raw = ''
          function()
            require("nvim-ts-autotag").setup({})
            require("nvim-ts-autotag.internal").attach(vim.api.nvim_get_current_buf())
          end
        '';
      };
    };
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
