vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({ "i", "v" }, "jk", "<Esc>", { desc = "Return to normal mode" })

vim.keymap.set("n", "<leader>e", ":Ex<CR>", { desc = "Open netrw" })

vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split the window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split the window horizontally" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })
vim.keymap.set("n", "<leader>wd", ":close<CR>", { desc = "Close window" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format the file" })

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic"})
vim.keymap.set("n", "<leader>[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic"})
vim.keymap.set("n", "<leader>]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic"})
