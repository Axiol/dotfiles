-- Enable correct colors
vim.o.termguicolors = true

-- Make VIM faster
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Hide the INSERT / NORMAL / ...
vim.o.showmode = false

-- Write good
vim.o.fileencoding = "utf-8"

-- Show the numbers
vim.wo.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- Sync clipboard with OS
vim.o.clipboard = "unnamedplus"

-- Let there be long lines
vim.o.wrap = false
vim.o.linebreak = true
vim.o.whichwrap = "bs<>[]hl"
vim.o.backspace = "indent,eol,start"

-- Highlight the current line
vim.o.cursorline = true

-- Enable mouse support
vim.o.mouse = "a"

-- Correct indentation
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.expandtab = true

-- Allow to search while ignoring the case, except if you ask for it
vim.o.ignorecase = true
vim.o.smartcase = true

-- Highlight on search
vim.o.hlsearch = false

-- Save the undi history
vim.o.undofile = true

-- Keep the signcolumn on
vim.wo.signcolumn = "yes"

-- Don't create backup file
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- Improve the completion menu
vim.o.completeopt = "menuone,noselect"

-- Split at the correct position
vim.o.splitbelow = true
vim.o.splitright = true

-- Show tab line
vim.o.showtabline = 2
