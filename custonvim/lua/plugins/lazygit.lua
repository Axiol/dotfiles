local add = MiniDeps.add

add({
  source = "kdheepak/lazygit.nvim",
  depends = { "nvim-lua/plenary.nvim" }
})

vim.keymap.set('n', '<leader>gg', ":LazyGit<CR>", { desc = 'LazyGit' })
