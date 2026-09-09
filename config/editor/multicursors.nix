{
  # ── Multicursors ──
  plugins.multicursors = {
    enable = true;

    # Commands are created by the plugin; load it on their first use.
    lazyLoad.settings.cmd = [
      "MCstart"
      "MCvisual"
      "MCunderCursor"
      "MCclear"
      "MCpattern"
      "MCvisualPattern"
    ];
    settings.normal_keys = {
      "<Down>" = {
        method = {
          __raw = "require('multicursors.normal_mode').create_down";
        };
        opts.desc = "Create down";
      };
      "<Up>" = {
        method = {
          __raw = "require('multicursors.normal_mode').create_up";
        };
        opts.desc = "Create up";
      };
    };
  };

  keymaps = [
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>m";
      action = "<cmd>MCunderCursor<cr>";
      options.desc = "Start multicursor at cursor";
    }
  ];
}
