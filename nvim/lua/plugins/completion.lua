vim.pack.add({
  { src = "https://github.com/echasnovski/mini.completion" },
})

vim.o.completeopt = "menuone,noselect,fuzzy"

require("mini.completion").setup()

vim.keymap.set("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
vim.keymap.set("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })

vim.keymap.set("i", "<CR>", function()
  if vim.fn.pumvisible() == 1 then
    local selected = vim.fn.complete_info({ "selected" }).selected ~= -1
    return selected and "<C-y>" or "<C-y><CR>"
  end
  return "<CR>"
end, { expr = true })
