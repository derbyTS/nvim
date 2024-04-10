return {
	"rcarriga/nvim-dap-ui",
	-- event = { "bufreadpre", "bufnewfile" },
	dependencies = { "nvim-neotest/nvim-nio" },
	config = function()
		require("dapui").setup()
	end,
}
