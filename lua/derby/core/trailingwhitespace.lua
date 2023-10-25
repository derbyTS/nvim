function SetExtraWhitespaceHighlight()
	-- Check if we are in normal mode before applying highlighting
	if vim.fn.mode() == "n" then
		vim.cmd("highlight ExtraWhitespace ctermbg=1 guibg=#EED7DC")
		vim.cmd("match ExtraWhitespace /\\s\\+$/")
	end
end

vim.cmd("autocmd InsertEnter * lua vim.cmd('match none')")
vim.cmd("autocmd InsertLeave * lua SetExtraWhitespaceHighlight()")
