{ pkgs, ... }:
{
  # ══════════════════════════════════════════════
  #  Rust Language Module
  #  LSP: rust-analyzer  |  Formatter: rustfmt  |  DAP: codelldb
  # ══════════════════════════════════════════════

  # ── LSP Server ──
  plugins.lsp.servers.rust_analyzer = {
    enable = true;
    installCargo = false;
    installRustc = false;
  };

  # ── Formatter ──
  plugins.conform-nvim.settings.formatters_by_ft.rust = [ "rustfmt" ];

  # ── DAP Adapter & Configuration ──
  plugins.dap.adapters.executables.codelldb = {
    command = "codelldb";
  };

  plugins.dap.configurations.rust = [
    {
      name = "Rust: Launch file";
      type = "codelldb";
      request = "launch";
      program = "\${fileDirname}/\${fileBasenameNoExtension}";
      cwd = "\${workspaceFolder}";
      stopOnEntry = false;
    }
  ];

  # ── Treesitter Grammar ──
  plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
    rust
  ];
}
