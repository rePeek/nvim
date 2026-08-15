{ pkgs, ... }:
{
  # ══════════════════════════════════════════════
  #  Nix Language Module
  #  LSP: nil  |  Formatter: nixfmt-rfc-style
  # ══════════════════════════════════════════════

  # ── LSP Server ──
  plugins.lsp.servers.nil_ls = {
    enable = true;
    settings = {
      nil = {
        nix = {
          flake = {
            autoArchive = true;
            autoEvalInputs = true;
          };
        };
      };
    };
  };

  # ── Formatter ──
  plugins.conform-nvim.settings.formatters_by_ft.nix = [ "nixfmt-rfc-style" ];

  # ── Treesitter Grammar ──
  plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
    nix
  ];
}
