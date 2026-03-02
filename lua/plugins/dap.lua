return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "jay-babu/mason-nvim-dap.nvim",
    },
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Breakpoint",
      },
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "Toggle DAP UI",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<leader>dt",
        function()
          require("dap-go").debug_test()
        end,
        desc = "Debug Test",
      },
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()

      -- Open UI automatically, but no listeners to close it
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end

      -- Essential Go/WSL setup
      require("dap-go").setup({
        delve = {
          detached = false,
          initialize_timeout_sec = 20,
        },
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = { ensure_installed = { "delve" } },
  },
}
