{
  plugins.dap = {
    enable = true;

    adapters = {
      executables = {
        codelldb = {
          command = "codelldb";
        };
      };
    };

    configurations = {
      cpp = [
        {
          name = "C/C++: Launch file";
          type = "codelldb";
          request = "launch";
          program = "\${fileDirname}/\${fileBasenameNoExtension}";
          cwd = "\${workspaceFolder}";
          stopOnEntry = false;
        }
      ];
      rust = [
        {
          name = "Rust: Launch file";
          type = "codelldb";
          request = "launch";
          program = "\${fileDirname}/\${fileBasenameNoExtension}";
          cwd = "\${workspaceFolder}";
          stopOnEntry = false;
        }
      ];
      python = [
        {
          name = "Python: Launch file";
          type = "codelldb";
          request = "launch";
          program = "\${file}";
          cwd = "\${workspaceFolder}";
          stopOnEntry = false;
        }
      ];
    };
  };

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
}
