return {
  -- Mason: tool/package manager
  {
    "williamboman/mason.nvim",
    opts = {},
  },

  -- Bridges mason and nvim-dap, auto-installs codelldb
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    opts = {
      ensure_installed = { "codelldb" },
      automatic_installation = true,
    },
  },

  -- DAP UI (panels: variables, call stack, console)
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    opts = {},
  },

  -- Core DAP client
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      local dap = require("dap")

      -- codelldb adapter (installed by mason)
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
          args = { "--port", "${port}" },
        },
      }

      -- C/C++ launch configuration (prompts for binary path)
      dap.configurations.c = {
        {
          name = "Launch",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      dap.configurations.cpp = dap.configurations.c

      -- Auto open/close UI with the debug session
      dap.listeners.after.event_initialized["dapui_config"] = function() require("dapui").open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() require("dapui").close() end
      dap.listeners.before.event_exited["dapui_config"] = function() require("dapui").close() end
    end,
  },
}
