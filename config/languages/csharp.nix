{
  lib,
  pkgs,
  ...
}:
let
  filterGodotGenerated = lib.nixvim.mkRaw ''
    function(item)
      if item.file
        and item.file:find("/Godot.SourceGenerators/", 1, true)
      then
        return false
      end

      return item
    end
  '';
in
{
  # ══════════════════════════════════════════════
  #  C# / .NET Language Module
  #  LSP / Formatter: roslyn.nvim
  # ══════════════════════════════════════════════
  # roslyn.nvim manages its roslyn_ls dependency; do not enable roslyn_ls separately.
  plugins.roslyn = {
    enable = true;
    settings = {
      filewatching = "auto";
      broad_search = false;
      lock_target = false;
    };
  };

  # Filter Godot source-generator virtual paths that Snacks cannot open as files.
  plugins.snacks.settings.picker.sources = {
    lsp_definitions = {
      transform = filterGodotGenerated;
      unique_lines = true;
    };
    lsp_declarations = {
      transform = filterGodotGenerated;
      unique_lines = true;
    };
    lsp_implementations = {
      transform = filterGodotGenerated;
      unique_lines = true;
    };
    lsp_type_definitions = {
      transform = filterGodotGenerated;
      unique_lines = true;
    };
    lsp_references = {
      transform = filterGodotGenerated;
      unique_lines = true;
    };
  };

  # ── Formatter ──
  # Roslyn already has the project workspace and .editorconfig; avoid a second CLI workspace load.
  plugins.conform-nvim.settings.formatters_by_ft.cs = [ ];

  # ── Treesitter Grammar ──
  plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
    c_sharp
  ];
}
