{ pkgs, ... }:
{
  # ══════════════════════════════════════════════
  #  C/C++ Language Module
  #  LSP: clangd  |  Formatter: clang-format  |  DAP: codelldb
  # ══════════════════════════════════════════════

  # ── LSP Server ──
  plugins.lsp.servers.clangd = {
    enable = true;
    extraOptions = {
      cmd = [
        "clangd"
        "--background-index"
        "--clang-tidy"
        "--header-insertion=never"
      ];
    };
  };

  # ── Formatter ──
  plugins.conform-nvim.settings.formatters_by_ft = {
    c = [ "clang_format" ];
    cpp = [ "clang_format" ];
  };

  # ── DAP Configuration ──
  plugins.dap.configurations.cpp = [
    {
      name = "C/C++: Launch file";
      type = "codelldb";
      request = "launch";
      program = "\${fileDirname}/\${fileBasenameNoExtension}";
      cwd = "\${workspaceFolder}";
      stopOnEntry = false;
    }
  ];

  # ── Treesitter Grammar ──
  plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
    c
    cpp
  ];
}
