{ pkgs, ... }:
{
  # ══════════════════════════════════════════════
  #  C/C++ Language Module
  #  LSP: clangd  |  Formatter: clang-format  |  DAP: lldb-dap
  # ══════════════════════════════════════════════

  # ── LSP Server ──
  plugins.lsp.servers.clangd = {
    enable = true;
    extraOptions = {
      cmd = [
        "clangd"
        "--background-index"
        "--clang-tidy"
        "--header-insertion=iwyu"
      ];
    };
  };

  # ── Formatter ──
  plugins.conform-nvim.settings.formatters_by_ft = {
    c = [ "clang_format" ];
    cpp = [ "clang_format" ];
  };

  # ── DAP Adapter & Configuration ──
  plugins.dap.adapters.executables.lldb-dap = {
    command = "lldb-dap";
  };

  # ── DAP Launch Configs ──
  plugins.dap.configurations = {
    c = [
      {
        name = "Launch file";
        type = "lldb-dap";
        request = "launch";
        program = "\${fileDirname}/\${fileBasenameNoExtension}";
        cwd = "\${workspaceFolder}";
        stopOnEntry = false;
      }
    ];
    cpp = [
      {
        name = "Launch file";
        type = "lldb-dap";
        request = "launch";
        program = "\${fileDirname}/\${fileBasenameNoExtension}";
        cwd = "\${workspaceFolder}";
        stopOnEntry = false;
      }
    ];
  };

  # ── Treesitter Grammar ──
  plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
    c
    cpp
  ];
}
