return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"windwp/nvim-ts-autotag",
	},
	config = function()
		-- Force downloading/using pre-compiled C source files to bypass CLI tree-sitter version mismatches
		require("nvim-treesitter.install").prefer_git = true

		local ok, configs = pcall(require, "nvim-treesitter.configs")
		if ok then
			configs.setup({
				highlight = { enable = true },
				indent = { enable = true },
				autotag = { enable = true },
				ensure_installed = {
					"comment",
					"json",
					"javascript",
					"typescript",
					"tsx",
					"yaml",
					"html",
					"css",
					"markdown",
					"markdown_inline",
					"svelte",
					"graphql",
					"bash",
					"lua",
					"vim",
					"dockerfile",
					"gitignore",
					"java",
					"go",
					"gomod",
					"gowork",
					"gosum",
					"rust",
					"latex",
					"hcl",
				},
			})
		end
	end,
}
