{ pkgs, ... }:
{
  # ══════════════════════════════════════════════
  #  Markdown Language Module
  #  LSP: marksman  |  Formatter: prettierd
  # ══════════════════════════════════════════════

  # ── System packages for Markdown tools ──
  extraPackages = with pkgs; [
    marksman
    prettierd
  ];

  # ── LSP Server ──
  plugins.lsp.servers.marksman = {
    enable = true;
  };

  # ── Formatter ──
  plugins.conform-nvim.settings.formatters_by_ft = {
    markdown = [ "prettierd" ];
  };

  # ── render-markdown.nvim — Markdown Rendering ──
  plugins.render-markdown = {
    enable = true;
    settings = {
      render_modes = [
        "n"
        "c"
        "t"
      ];
      anti_conceal = {
        enabled = false;
      };
      heading = {
        backgrounds = [ "Normal" ];
      };
      code = {
        disable_background = true;
        inline = false;
        # 顶部显示语言
        language = true;
        language_icon = false;
        language_name = true;
        language_info = false;

        # nix 放在横线中央
        position = "center";

        # 不要 sign column 里的语言图标
        sign = false;

        # 边框
        border = "thin";
        language_border = "─";
        language_left = " ";
        language_right = " ";
        above = "─";
        below = "─";

        width = "block";
        right_pad = 1;
      };
    };
  };
  # ── Treesitter Grammar ──
  plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
    markdown
    markdown_inline
  ];
}
