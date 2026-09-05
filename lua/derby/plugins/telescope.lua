return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "truncate" },
				-- path_display = { "smart" },
				-- path_display = { "filename_first" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist, -- Sends ALL results automatically
						["<C-t>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<C-d>"] = actions.delete_buffer, -- explicitly set buffer deletion in insert mode
					},
					n = {
						["d"] = actions.delete_buffer, -- delete buffer in normal mode inside telescope
					},
				},
			},
			pickers = {
				buffers = {
					-- initial_mode = "normal", -- Open buffer list directly in Normal mode for fast 'd' deletion
					sort_mru = true,
					-- ignore_current_buffer = true,
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})

		telescope.load_extension("fzf")

		-- -- set keymaps
		-- local keymap = vim.keymap -- for conciseness
		--
		-- keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		-- keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		-- keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		-- keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
	end,
}
