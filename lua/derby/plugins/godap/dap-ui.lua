return {
	"rcarriga/nvim-dap-ui",
	-- event = { "bufreadpre", "bufnewfile" },
	dependencies = {
		"mfussenegger/nvim-dap",
	},
	config = function()
		require("dapui").setup()
	end,
}
