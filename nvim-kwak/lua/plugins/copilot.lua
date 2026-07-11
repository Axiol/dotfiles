vim.pack.add({
  "https://github.com/zbirenbaum/copilot.lua",
})

require("copilot").setup({
  suggestion = {
    -- Show suggestions automatically as you type.
    auto_trigger = true,
    hide_during_completion = true,
    keymap = {
      accept = "<C-l>",
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },

  panel = { enabled = false },
})
