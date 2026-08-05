{
  # ══════════════════════════════════════════════
  #  Oil.nvim — File Explorer (NixOS-friendly)
  #  Kept alongside snacks.explorer for users who prefer it
  # ══════════════════════════════════════════════
  plugins.oil = {
    enable = true;
    settings = {
      default_file_explorer = false; # snacks.explorer is primary
      delete_to_trash = true;
      skip_confirm_for_simple_edits = true;
      view_options = {
        show_hidden = true;
      };
    };
  };

  keymaps = [
    {
      key = "<leader>E";
      mode = "n";
      action = "<cmd>Oil<CR>";
      options = {
        desc = "Oil file explorer (alt)";
      };
    }
  ];
}
