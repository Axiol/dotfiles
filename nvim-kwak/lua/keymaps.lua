vim.keymap.set("n", "<Leader>rs", ":restart<CR>", { desc = "Reload configuration" })
vim.keymap.set("n", "<Leader>-", ":Explore<CR>", { desc = "Open Netrw" })
vim.keymap.set("i", "jk", "<Esc>", { desc = "Return to normal mode" })

-- Move between windows with Ctrl + h/j/k/l
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
