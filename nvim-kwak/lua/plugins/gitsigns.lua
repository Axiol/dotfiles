vim.pack.add({
  "https://github.com/lewis6991/gitsigns.nvim"
})

vim.keymap.set("n", "<leader>bb", "<CMD>Gitsigns blame_line<CR>", { desc = "Blame the current line" })
vim.keymap.set("n", "<leader>BB", "<CMD>Gitsigns blame<CR>", { desc = "Blame the file" })
