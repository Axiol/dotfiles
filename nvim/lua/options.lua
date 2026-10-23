-- Make nvim snapier
vim.opt.updatetime = 250

-- Confirm when closing with unsaved buffers
vim.opt.confirm = true

-- Leader key to the space bar
vim.g.mapleader = " "

-- Use nice colors
vim.opt.termguicolors = true

-- Display line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

-- Use 2 spaces tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- Non sensitive search unless I want it to
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Use the system clipboard
vim.opt.clipboard = "unnamedplus"

-- Leave space around the cursor
vim.opt.scrolloff = 8

-- Open new split on the right and at the bottom
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Disable logging
vim.env.NVIM_LOG_FILE = "/dev/null"

-- Highlight the current line
vim.opt.cursorline = true

-- The statusline already shows the mode, so drop the native "-- INSERT --" text
vim.opt.showmode = false

-- Reclaim the command line's row; it reappears on demand (typing ":", messages)
vim.opt.cmdheight = 0

-- Round the floating boxes
vim.o.winborder = "rounded"

-- Disable line wrap
vim.opt.wrap = false
