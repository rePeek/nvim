{
  # ══════════════════════════════════════════════
  #  Grug Far — Search & Replace (from LazyVim)
  # ══════════════════════════════════════════════
  plugins.grug-far = {
    enable = true;

    # The custom <leader>sr mapping below triggers this explicitly.
    lazyLoad.settings.lazy = true;
    settings = {
      headerMaxWidth = 80;
    };
  };

  # lz-n loads the plugin before running the existing custom keymap action.
  plugins.lz-n.keymaps = [
    {
      plugin = "grug-far.nvim";
      key = "<leader>sr";
      mode = [
        "n"
        "x"
      ];
      action = {
        __raw = ''
          function()
            local grug = require("grug-far")
            local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
            grug.open({
              transient = true,
              prefills = {
                filesFilter = ext and ext ~= "" and "*." .. ext or nil,
              },
            })
          end
        '';
      };
      options = {
        desc = "Search and Replace";
      };
    }
  ];
}
