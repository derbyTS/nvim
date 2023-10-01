return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count
local colorscheme = require("lualine.themes.auto")
		local new_colors = {
			EED7DC = "#EED7DC",
			FFCCD1 = "#FFCCD1",
			FF8B99 = "#FF8B99",
			FFDA7B = "#FFCCD1",
			FF3F56 = "#FF3F56",
		}


		colorscheme.normal.a.bg = new_colors.EED7DC
		colorscheme.insert.a.bg = new_colors.FFCCD1
		colorscheme.visual.a.bg = new_colors.FF8B99
		colorscheme.command = {
			a = {
				gui = "bold",
				bg = new_colors.FF3F56,
				fg = new_colors.black, -- black
			},
		}

		-- configure lualine with modified theme
		lualine.setup({
			options = {
				theme = colorscheme,
			},
			sections = {
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
			},
		})
	end,
}
