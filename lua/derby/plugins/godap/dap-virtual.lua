return {
	"theHamsta/nvim-dap-virtual-text",
	-- event = { "bufreadpre", "bufnewfile" },
	config = function()
		require("nvim-dap-virtual-text").setup()
	end,
}
