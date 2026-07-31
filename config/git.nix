{
  # ══════════════════════════════════════════════
  #  Gitsigns — inline git decorations
  # ══════════════════════════════════════════════
  plugins.gitsigns = {
    enable = true;
    settings = {
      current_line_blame = true;
      current_line_blame_opts = {
        virt_text = true;
        delay = 500;
      };
    };
  };

  # ══════════════════════════════════════════════
  #  Lazygit — floating git terminal
  # ══════════════════════════════════════════════
  plugins.lazygit = {
    enable = true;
  };
}
