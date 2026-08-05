# ══════════════════════════════════════════════
#  Nixvim Configuration — LazyVim-inspired, Fully Nix
#
#  Structure:
#    core/        — options, keymaps, autocmds
#    ui/          — snacks, colorscheme, lualine, bufferline, noice
#    editor/      — oil, flash, trouble, todo-comments, grug-far, which-key
#    coding/      — treesitter, lsp, completion, conform, dap
#    git/         — gitsigns, lazygit
#    languages/   — cpp, rust
#
#  Design:
#    - No lazy.nvim / Mason — everything managed by Nix
#    - LazyVim UX (snacks, which-key, trouble, flash)
#    - Nix-managed toolchains (clangd, rust-analyzer, etc.)
# ══════════════════════════════════════════════
{
  imports = [
    ./core
    ./ui
    ./editor
    ./coding
    ./git
    ./languages
  ];
}
