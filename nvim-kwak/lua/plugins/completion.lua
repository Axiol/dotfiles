vim.pack.add({
  { src = "https://github.com/echasnovski/mini.completion" },
})

-- menuone: show the menu even for a single match; noselect: never auto-pick an
-- item (so <CR> stays a newline); fuzzy: native fuzzy matching (Neovim 0.11+).
vim.o.completeopt = "menuone,noselect,fuzzy"

require("mini.completion").setup()

-- <Tab> / <S-Tab> walk the popup menu, and fall back to a real Tab otherwise.
vim.keymap.set("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
vim.keymap.set("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
