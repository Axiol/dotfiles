return {
  {
    "folke/tokyonight.nvim",
    enabled = false,
  },

  {
    "catppuccin/nvim",
    enabled = false,
  },

  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = true,
    name = "oxocarbon",
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "oxocarbon",
    },
  },
}
