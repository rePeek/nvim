{
  # ══════════════════════════════════════════════
  #  Which-Key — Keymap Discovery
  # ══════════════════════════════════════════════
  plugins.which-key = {
    enable = true;
    settings = {
      preset = "helix";
      icons = { enabled = false; };
      spec = [
        {
          __unkeyed-1 = "<leader>c";
          group = "code";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "<leader>d";
          group = "diagnostics";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "<leader>e";
          group = "explorer";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "<leader>g";
          group = "git";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "<leader>s";
          group = "symbols";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "<leader>u";
          group = "ui";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "<leader>w";
          group = "windows";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "[";
          group = "prev";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "]";
          group = "next";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "g";
          group = "goto";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "z";
          group = "fold";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "gx";
          desc = "Open with system app";
          mode = [
            "n"
            "x"
          ];
        }
      ];
    };
  };

  keymaps = [
    {
      key = "<leader>?";
      mode = "n";
      action = {
        __raw = "function() require('which-key').show({ global = false }) end";
      };
      options = {
        desc = "Buffer Keymaps (which-key)";
      };
    }
  ];
}
