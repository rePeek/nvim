{ ... }:

{
  # nvim-dap upstream moved to Codeberg, but Codeberg may block
  # some IPs. Use the synchronized GitHub mirror instead.
  nixpkgs.overlays = [
    (final: prev: {
      vimPlugins = prev.vimPlugins.extend (_vfinal: vprev: {
        nvim-dap = vprev.nvim-dap.overrideAttrs (old: {
          src = final.fetchgit {
            url = "https://github.com/mfussenegger/nvim-dap.git";

            inherit (old.src) rev;
            hash = old.src.outputHash;
          };
        });
      });
    })
  ];

  # ══════════════════════════════════════════════
  #  DAP — Debug Adapter Protocol Framework
  #  Language-specific debug configs go in languages/*.nix
  # ══════════════════════════════════════════════
  plugins.dap = {
    enable = true;
  };

  # ── DAP UI ──
  plugins.dap-ui = {
    enable = true;
  };

  # ── Auto-open DAP UI on debug start ──
  extraConfigLua = ''
    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  '';

  # ── DAP Keymaps ──
  keymaps = [
    {
      key = "<leader>db";
      mode = "n";
      action = {
        __raw = "function() require('dap').toggle_breakpoint() end";
      };
      options = {
        desc = "Toggle breakpoint";
      };
    }
    {
      key = "<leader>dc";
      mode = "n";
      action = {
        __raw = "function() require('dap').continue() end";
      };
      options = {
        desc = "Continue";
      };
    }
    {
      key = "<leader>dn";
      mode = "n";
      action = {
        __raw = "function() require('dap').step_over() end";
      };
      options = {
        desc = "Step over";
      };
    }
    {
      key = "<leader>ds";
      mode = "n";
      action = {
        __raw = "function() require('dap').step_into() end";
      };
      options = {
        desc = "Step into";
      };
    }
    {
      key = "<leader>do";
      mode = "n";
      action = {
        __raw = "function() require('dap').step_out() end";
      };
      options = {
        desc = "Step out";
      };
    }
    {
      key = "<leader>dr";
      mode = "n";
      action = {
        __raw = "function() require('dap').restart() end";
      };
      options = {
        desc = "Restart";
      };
    }
    {
      key = "<leader>dt";
      mode = "n";
      action = {
        __raw = "function() require('dap').terminate() end";
      };
      options = {
        desc = "Terminate";
      };
    }
    {
      key = "<leader>du";
      mode = "n";
      action = {
        __raw = "function() require('dapui').toggle() end";
      };
      options = {
        desc = "Toggle DAP UI";
      };
    }
  ];
}
