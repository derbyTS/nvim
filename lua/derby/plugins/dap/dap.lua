return {
	"mfussenegger/nvim-dap",
	config = function()
		local dap = require("dap")

		-- 1. Locate the Mason installation of codelldb
		local codelldb_path = vim.fn.stdpath("data") .. "/mason/bin/codelldb"

		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = codelldb_path,
				args = { "--port", "${port}" },
			},
		}

		-- 2. Define the configuration for C and C++
		local config = {
			{
				name = "Launch file",
				type = "codelldb", -- Matches the adapter name above
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				-- This allows you to see terminal output more clearly
				console = "integratedTerminal",
			},
		}

		dap.configurations.cpp = config
		dap.configurations.c = config
	end,
}
