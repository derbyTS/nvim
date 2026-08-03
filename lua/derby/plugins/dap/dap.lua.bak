return {
	"mfussenegger/nvim-dap",
	config = function()
		local dap_setup = require("dap")
		dap_setup.adapters.lldb = {
			type = "executable",
			command = "/opt/homebrew/opt/llvm/bin/lldb-vscode", -- adjust as needed, must be absolute path
			name = "lldb",
		}

		dap_setup.configurations.cpp = {
			{
				name = "launch",
				type = "lldb",
				request = "launch",
				program = function()
					return vim.fn.input("path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stoponentry = false,
				args = {},
			},
			{
				name = "With Input",
				type = "lldb",
				request = "launch",
				program = function()
					return vim.fn.input("path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stoponentry = false,
				args = {},
				input = function()
					return vim.fn.input("input path : ", vim.fn.getcwd() .. "/", "file")
				end,
			},
		}

		dap_setup.configurations.c = dap_setup.configurations.cpp
	end,
}
