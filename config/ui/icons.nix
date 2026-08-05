{
  # ══════════════════════════════════════════════
  #  Icons — mini.icons + web-devicons
  # ══════════════════════════════════════════════

  # ── Mini.icons — File/directory/filetype icons ──
  plugins.mini-icons = {
    enable = true;
    settings = {
      file = {
        ".keep" = {
          glyph = "󰊢";
          hl = "MiniIconsGrey";
        };
        "devcontainer.json" = {
          glyph = "";
          hl = "MiniIconsAzure";
        };
      };
      filetype = {
        dotenv = {
          glyph = "";
          hl = "MiniIconsYellow";
        };
      };
    };
  };

  # ── Web Devicons (fallback for plugins that use nvim-web-devicons) ──
  plugins.web-devicons.enable = true;
}
