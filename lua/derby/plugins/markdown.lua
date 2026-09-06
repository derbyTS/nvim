return {
	"MeanderingProgrammer/render-markdown.nvim",
	version = false, -- pull main branch for Neovim 0.12 support
	opts = {
		file_types = { "markdown" },
		-- Exclude floating popups/LSP hovers from rendering markdown
		win_options = {
			conceallevel = { default = 2 },
		},
		overrides = {
			buftype = {
				nofile = { enabled = false },
				prompt = { enabled = false },
				popup = { enabled = false },
			},
		},
	},
}

-- return {
-- 	"MeanderingProgrammer/render-markdown.nvim",
-- 	dependencies = { "nvim-treesitter/nvim-treesitter" },
--
-- 	opts = {},
-- }
