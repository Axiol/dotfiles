return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "frappe",
      term_colors = true,
      integrations = {
        bufferline = true,
      },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
