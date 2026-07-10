vim.pack.add({
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/ibhagwan/fzf-lua",
})

local fzf = require("fzf-lua")

fzf.setup({
  files = {
    -- fzf-lua defaults + --hidden so dotfiles/dotdirs show up
    fd_opts = [[--color=never --hidden --type f --type l --exclude .git --exclude .jj]],
    rg_opts = [[--color=never --hidden --files -g "!.git" -g "!.jj"]],
  },
})

local launch_dir = vim.fn.getcwd()

vim.keymap.set("n", "<leader>ff", function()
  fzf.files({ cwd = launch_dir })
end, { desc = "Find files" })

vim.keymap.set("n", "<leader>fg", function()
  fzf.live_grep({ cwd = launch_dir })
end, { desc = "Live grep" })

vim.keymap.set("n", "<leader>,", fzf.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fr", fzf.oldfiles, { desc = "Old files" })
vim.keymap.set("n", "<leader>gr", fzf.lsp_references, { desc = "LSP references" })
vim.keymap.set("n", "<leader>xx", fzf.diagnostics_document, { desc = "Document diagnostics" })
