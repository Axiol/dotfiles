vim.pack.add({
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
})

require("mason").setup()

-- Teach lua_ls about the `vim` global so it stops flagging it as undefined.
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
    },
  },
})

require("mason-lspconfig").setup({
  -- Servers to keep installed. automatic_enable (on by default) calls
  -- vim.lsp.enable() for each installed server, so no per-server setup needed.
  ensure_installed = { "lua_ls", "ts_ls", "gopls", "tailwindcss" },
})

-- Diagnostics presentation.
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  severity_sort = true,
  float = { border = "rounded", source = true },
})

-- Buffer-local setup that runs whenever a language server attaches.
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Set up LSP keymaps on attach",
  callback = function(args)
    local buf = args.buf
    local function map(keys, fn, desc)
      vim.keymap.set("n", keys, fn, { buffer = buf, desc = "LSP: " .. desc })
    end

    -- K (hover), grn (rename), gra (code action), grr (references),
    -- gri (implementation), gO (symbols), [d / ]d (diagnostics).
    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("gD", vim.lsp.buf.declaration, "Go to declaration")
    map("<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")
  end,
})
