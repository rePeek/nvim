{
  # ── Code Diff (split-window diff viewer) ──
  plugins.codediff = {
    enable = true;

    settings = {
      highlights = {
        line_insert = "#2a3325";
        line_delete = "#362c2e";
        char_insert = "#3d4f35";
        char_delete = "#4d3538";
      };
      keymaps = {
        view = {
          quit = "q";
          toggle_explorer = "<leader>b";
          next_hunk = "]c";
          prev_hunk = "[c";
          next_file = "]f";
          prev_file = "[f";
          diff_get = "do";
          diff_put = "dp";
        };
        explorer = {
          select = "<CR>";
          hover = "K";
          refresh = "R";
        };
      };
    };
  };
}
