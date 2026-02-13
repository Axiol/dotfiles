local add = MiniDeps.add

add({
  source = "nvim-telescope/telescope.nvim",
  checkout = "master",
  depends = { "nvim-lua/plenary.nvim" },
})

require("telescope").setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--no-ignore',
      '--hidden',
    },
  },
  pickers = {
    find_files = {
      no_ignore = true,
      hidden = true
    },
  },
}

vim.keymap.set('n', '<leader>ff', ":Telescope find_files<CR>", { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', ":Telescope live_grep<CR>", { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', ":Telescope buffers<CR>", { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fd', ":Telescope diagnostics<CR>", { desc = 'Telescope diagnostics' })
vim.keymap.set('n', '<leader>fh', ":Telescope help_tags<CR>", { desc = 'Telescope help' })
