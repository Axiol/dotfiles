vim.pack.add({
  "https://codeberg.org/andyg/leap.nvim",
})

vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)", { desc = "Leap" })
vim.keymap.set("n", "S", "<Plug>(leap-from-window)", { desc = "Leap from window" })
