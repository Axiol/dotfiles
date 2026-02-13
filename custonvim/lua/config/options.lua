-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Highlight the current line
vim.opt.cursorline = true

-- Prevent wrap
vim.opt.wrap = false

-- Leave space around the cursor
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

-- Soft 2 spaces tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- Indent correctly
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Disable swap file creation
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- Non case sensitive search and instant match
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = false

-- Use those colors
vim.opt.termguicolors = true

-- Always show the sign coloumn
vim.opt.signcolumn = "yes"

-- Show match brackets
vim.opt.showmatch = true
vim.opt.matchtime = 2

-- Make it fast
vim.opt.updatetime = 300

-- Update file if updated outsite nvim
vim.opt.autoread = true

-- Make the backspace go everywhere
vim.opt.backspace = "indent,eol,start"

-- Copy to the system clipboard
vim.opt.clipboard:append("unnamedplus")

-- Include subdirectories in search
vim.opt.path:append("**")

-- Encode the file correctly
vim.opt.encoding = "UTF-8"

-- Add a border to the pop-up window
vim.opt.winborder = "rounded"
