local add, now = MiniDeps.add, MiniDeps.now

-- Ajouter le plugin
add({
  source = "nvim-treesitter/nvim-treesitter",
  checkout = "master",
})

-- Charger le plugin immédiatement
now(function()
  require("nvim-treesitter.configs").setup({
    ensure_installed = { "lua", "javascript", "typescript", "css", "html", "markdown" },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  })
end)
