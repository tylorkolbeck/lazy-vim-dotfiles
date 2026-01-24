-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "jk", "<ESC>", { noremap = true })
vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { noremap = true })

-- Compile and run current C++ file from its directory
vim.keymap.set("n", "<leader>r", function()
  local file = vim.fn.expand("%:t") -- filename.cpp
  local dir = vim.fn.expand("%:p:h") -- full path to directory
  local output = vim.fn.expand("%:t:r") -- filename without extension

  vim.cmd(
    "split | terminal cd "
      .. dir
      .. " && g++ -std=c++20 -Wall -Wextra -g "
      .. file
      .. " -o "
      .. output
      .. " && ./"
      .. output
  )

  vim.cmd("startinsert")
end, { desc = "Compile & Run C++ (file dir)" })
