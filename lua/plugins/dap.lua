return {
  -- Core DAP + Codelldb config
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
    },
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.open()
        end,
        desc = "REPL",
      },
    },
    config = function()
      local dap = require("dap")

      -- Mason-installed codelldb
      local mason_path = vim.fn.stdpath("data") .. "/mason"
      local codelldb_path = mason_path .. "/packages/codelldb/extension/adapter/codelldb"

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = codelldb_path,
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.cpp = {
        {
          name = "Build & Debug (codelldb)",
          type = "codelldb",
          request = "launch",

          program = "${workspaceFolder}/build/debug/src/debug",

          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},

          preLaunchTask = function()
            return {
              type = "shell",
              command = "cmake --build build/debug",
            }
          end,
        },
        -- {
        --   name = "Launch (codelldb)",
        --   type = "codelldb",
        --   request = "launch",
        --   program = "${workspaceFolder}/build/debug/src/debug",
        --   -- program = function()
        --   --   return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        --   -- end,
        --   cwd = "${workspaceFolder}",
        --   stopOnEntry = false,
        --   args = {},
        -- },
      }

      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp
      -- Go (Delve)
      require("dap-go").setup()

      -- Optional: explicitly define configurations (dap-go usually adds these)
      dap.configurations.go = dap.configurations.go
        or {
          {
            type = "go",
            name = "Debug File",
            request = "launch",
            program = "${file}",
          },
          {
            type = "go",
            name = "Debug Package",
            request = "launch",
            program = "${workspaceFolder}",
          },
          {
            type = "go",
            name = "Debug Test (File)",
            request = "launch",
            mode = "test",
            program = "${file}",
          },
          {
            type = "go",
            name = "Debug Test (Package)",
            request = "launch",
            mode = "test",
            program = "${workspaceFolder}",
          },
        }
    end,
  },

  -- DAP UI
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  -- Mason DAP integration
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      automatic_installation = true,
      ensure_installed = { "codelldb" },
    },
  },
}
