{
  # ══════════════════════════════════════════════
  #  Lualine — Status Line (LazyVim-inspired)
  # ══════════════════════════════════════════════
  plugins.lualine = {
    enable = false;
    settings = {
      options = {
        theme = "auto";
        globalstatus = true;
        disabled_filetypes = {
          statusline = [
            "dashboard"
            "alpha"
            "ministarter"
            "snacks_dashboard"
          ];
        };
        component_separators = {
          left = "│";
          right = "│";
        };
        section_separators = {
          left = "";
          right = "";
        };
      };
      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [
          "branch"
          "diff"
          "diagnostics"
        ];
        lualine_c = [ "filename" ];
        lualine_x = [
          "encoding"
          "fileformat"
          "filetype"
        ];
        lualine_y = [ "progress" ];
        lualine_z = [ "location" ];
      };
    };
  };
}
