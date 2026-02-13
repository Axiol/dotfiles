local oxo_bg = "#161616"
local oxo_fg = "#f2f4f8"
local oxo_base00 = "#262626"
local oxo_base01 = "#393939"
local oxo_base02 = "#525252"
local oxo_base03 = "#dde1e6"
local oxo_pink = "#ff7eb6"
local oxo_purple = "#be95ff"
local oxo_blue = "#78a9ff"
local oxo_cyan = "#3ddbd9"
local oxo_green = "#42be65"
local oxo_yellow = "#ffe97b"
local oxo_orange = "#ff832b"
local oxo_red = "#ee5396"

return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.sections = {
      lualine_c = { "filename" },
    }
    opts.options = {
      theme = {
        normal = {
          a = { fg = oxo_bg, bg = oxo_cyan, gui = "bold" },
          b = { fg = oxo_fg, bg = oxo_base01 },
          c = { fg = oxo_fg, bg = oxo_base00 },
        },
        insert = {
          a = { fg = oxo_bg, bg = oxo_green, gui = "bold" },
          b = { fg = oxo_fg, bg = oxo_base01 },
          c = { fg = oxo_fg, bg = oxo_base00 },
        },
        visual = {
          a = { fg = oxo_bg, bg = oxo_purple, gui = "bold" },
          b = { fg = oxo_fg, bg = oxo_base01 },
          c = { fg = oxo_fg, bg = oxo_base00 },
        },
        replace = {
          a = { fg = oxo_bg, bg = oxo_pink, gui = "bold" },
          b = { fg = oxo_fg, bg = oxo_base01 },
          c = { fg = oxo_fg, bg = oxo_base00 },
        },
        command = {
          a = { fg = oxo_bg, bg = oxo_red, gui = "bold" },
          b = { fg = oxo_fg, bg = oxo_base01 },
          c = { fg = oxo_fg, bg = oxo_base00 },
        },
        inactive = {
          a = { fg = oxo_base02, bg = oxo_base00 },
          b = { fg = oxo_base02, bg = oxo_base00 },
          c = { fg = oxo_base02, bg = oxo_base00 },
        },
      },
      section_separators = { left = "", right = "" },
      component_separators = { left = "", right = "" },
    }
  end,
}
