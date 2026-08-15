{
  # ── Multicursors ──
  plugins.multicursors = {
    enable = true;
    settings.normal_keys = {
      "<Down>" = {
        method = { __raw = "require('multicursors.normal_mode').create_down"; };
        opts.desc = "Create down";
      };
      "<Up>" = {
        method = { __raw = "require('multicursors.normal_mode').create_up"; };
        opts.desc = "Create up";
      };
    };
  };

  keymaps = [
    {
      mode = [ "n" "v" ];
      key = "<leader>m";
      action = "<cmd>MCstart<cr>";
      options.desc = "Start multicursor mode";
    }
  ];
}
