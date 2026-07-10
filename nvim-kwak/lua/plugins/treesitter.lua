vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

local ts = require("nvim-treesitter")

local ensure_installed = {
  "lua", "luadoc", "vim", "vimdoc", "query",
  "bash", "markdown", "markdown_inline", "json", "yaml",
}

ts.install(ensure_installed)

-- Set of parsers that CAN be installed, to guard auto-install against random
-- filetypes that have no parser at all.
local installable = {}
for _, lang in ipairs(ts.get_available()) do
  installable[lang] = true
end

local function enable(buf)
  vim.treesitter.start(buf)                                                   -- syntax highlighting
  vim.wo.foldmethod = "expr"
  vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"                         -- folding
  vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"      -- indent (experimental)
end

vim.api.nvim_create_autocmd("FileType", {
  desc = "Enable treesitter, auto-installing the parser on first use",
  callback = function(args)
    local buf = args.buf
    local ft = vim.bo[buf].filetype
    local lang = vim.treesitter.language.get_lang(ft) or ft

    -- Parser already usable (bundled with Neovim, or already installed).
    local ok, added = pcall(vim.treesitter.language.add, lang)
    if ok and added then
      enable(buf)
      return
    end

    -- Missing but installable: fetch it now, then enable. install() is async,
    -- so :wait() blocks until it's ready (one-time, only on first open).
    if installable[lang] then
      ts.install({ lang }):wait(300000)
      if vim.api.nvim_buf_is_valid(buf) then
        enable(buf)
      end
    end
  end,
})

-- Start with all folds open instead of collapsing the whole file.
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
