local add = MiniDeps.add

add({
  source = "stevearc/oil.nvim"
})

require("oil").setup()

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
