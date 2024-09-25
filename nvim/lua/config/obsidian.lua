return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	-- 	"BufReadPre /home/axiol/Documents/Mother Brain/*.md",
	-- 	"BufNewFile /home/axiol/Documents/Mother Brain/*.md",
	-- },
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("obsidian").setup({
			disable_frontmatter = true,
			workspaces = {
				{
					name = "personal",
					path = "/home/axiol/Documents/Mother Brain",
				},
			},
		})
		vim.opt.conceallevel = 1
	end,
}
