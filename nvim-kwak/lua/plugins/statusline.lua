vim.pack.add({
  "https://github.com/nvim-mini/mini.statusline"
})

require("mini.statusline").setup()

-- Replicate the old lualine look. mini.statusline's default sections already
-- mirror lualine's layout (mode | git+diagnostics | filename | fileinfo |
-- location) with no powerline separators, so we only restyle its highlight
-- groups with the oxocarbon palette. Mapping: lualine section a -> Mode*,
-- b -> Devinfo, c -> Filename/Fileinfo.
local oxo = {
  bg     = "#161616",
  fg     = "#f2f4f8",
  base00 = "#262626",
  base01 = "#393939",
  base02 = "#525252",
  pink   = "#ff7eb6",
  purple = "#be95ff",
  blue   = "#78a9ff",
  cyan   = "#3ddbd9",
  green  = "#42be65",
  red    = "#ee5396",
}

local function set_statusline_hl()
  local groups = {
    MiniStatuslineModeNormal  = { fg = oxo.bg, bg = oxo.cyan,   bold = true },
    MiniStatuslineModeInsert  = { fg = oxo.bg, bg = oxo.green,  bold = true },
    MiniStatuslineModeVisual  = { fg = oxo.bg, bg = oxo.purple, bold = true },
    MiniStatuslineModeReplace = { fg = oxo.bg, bg = oxo.pink,   bold = true },
    MiniStatuslineModeCommand = { fg = oxo.bg, bg = oxo.red,    bold = true },
    MiniStatuslineModeOther   = { fg = oxo.bg, bg = oxo.blue,   bold = true },
    MiniStatuslineDevinfo     = { fg = oxo.fg, bg = oxo.base01 },
    MiniStatuslineFilename    = { fg = oxo.fg, bg = oxo.base00 },
    MiniStatuslineFileinfo    = { fg = oxo.fg, bg = oxo.base00 },
    MiniStatuslineInactive    = { fg = oxo.base02, bg = oxo.base00 },
  }
  for name, val in pairs(groups) do
    vim.api.nvim_set_hl(0, name, val)
  end
end

set_statusline_hl()

-- Re-apply after any colorscheme (re)load so our overrides always win.
vim.api.nvim_create_autocmd("ColorScheme", {
  desc = "Re-apply oxocarbon statusline highlights",
  callback = set_statusline_hl,
})
