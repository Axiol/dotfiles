vim.pack.add({
  "https://github.com/kdheepak/lazygit.nvim",
})

vim.keymap.set("n", "<leader>gg", "<CMD>LazyGit<CR>", { desc = "Open lazygit" })
