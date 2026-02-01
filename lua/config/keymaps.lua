-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "jk", "<ESC>", { noremap = true })
vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { noremap = true })

-- C++ build helpers under <leader>m (make/build)
vim.keymap.set("n", "<leader>mc", function()
  local file = vim.fn.expand("%:t")
  local dir = vim.fn.expand("%:p:h")
  local output = vim.fn.expand("%:t:r")

  vim.cmd("split | terminal cd " .. dir .. " && g++ -std=c++20 -Wall -Wextra -g " .. file .. " -o " .. output)

  vim.cmd("startinsert")
end, { desc = "Compile C++ file" })

vim.keymap.set("n", "<leader>mr", function()
  local file = vim.fn.expand("%:t")
  local dir = vim.fn.expand("%:p:h")
  local output = vim.fn.expand("%:t:r")

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
end, { desc = "Compile & Run C++ file" })
