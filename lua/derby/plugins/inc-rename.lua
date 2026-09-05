return {
	"smjonas/inc-rename.nvim",
	config = function()
		require("inc_rename").setup()
		vim.opt.inccommand = "split"
	end,
}
