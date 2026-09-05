return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	opts = {
		options = {
			mode = "tabs",
			separator_style = "slant",
			-- always_show_bufferline = true,
			always_show_bufferline = false,
			-- Force zero offsets so tabline fills 100% width edge-to-edge
			offsets = {},
		},
	},
}

-- return {
-- 	"akinsho/bufferline.nvim",
-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
-- 	version = "*",
-- 	opts = {
-- 		options = {
-- 			-- mode = "tabs",
-- 			separator_style = "slant",
-- 			--I add this part for the no-neck-pain.nvim compatibility
-- 			mode = "buffers",
-- 			always_show_bufferline = true, -- Spans tabline full width regardless of splits
-- 			offsets = {},
-- 		},
-- 	},
-- }
