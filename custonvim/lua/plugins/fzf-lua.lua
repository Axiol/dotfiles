local add = MiniDeps.add

add({
  source = "ibhagwan/fzf-lua",
  checkout = "main",
  depends = { "nvim-tree/nvim-web-devicons" },
})

vim.keymap.set('n', '<leader>ff', ":FzfLua files<CR>", { desc = 'FzfLua find files' })
vim.keymap.set('n', '<leader>fg', ":FzfLua live_grep<CR>", { desc = 'FzfLua live grep' })
vim.keymap.set('n', '<leader>fb', ":FzfLua buffers<CR>", { desc = 'FzfLua buffers' })
vim.keymap.set('n', '<leader>fd', ":FzfLua diagnostics_document<CR>", { desc = 'FzfLua diagnostics' })
vim.keymap.set('n', '<leader>fh', ":FzfLua help_tags<CR>", { desc = 'FzfLua help' })
vim.keymap.set('n', '<leader>fr', ":FzfLua resume<CR>", { desc = 'FzfLua resume' })
