vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>nh", "nohl<CR>")

vim.keymap.set("n", "x", '"_x')

-- window management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- tab
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

local side_wins = {}

local function toggle_centered_buffer()
	-- If centered mode is active, close side splits and restore layout
	if vim.g.centered_mode then
		for _, win in ipairs(side_wins) do
			if vim.api.nvim_win_is_valid(win) then
				vim.api.nvim_win_close(win, true)
			end
		end
		side_wins = {}
		vim.g.centered_mode = false
		return
	end

	-- Auto-close NvimTree if visible to prevent margin distortion
	local tree_api_ok, tree_api = pcall(require, "nvim-tree.api")
	if tree_api_ok and tree_api.tree.is_visible() then
		tree_api.tree.close()
	end

	-- Close other standard splits so the target buffer gets full screen width
	vim.cmd("only")

	local current_win = vim.api.nvim_get_current_win()
	local width = vim.api.nvim_win_get_width(current_win)
	local target_width = 120
	local margin = math.floor((width - target_width) / 2)

	if margin > 10 then
		local side_opts =
			"setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nomodifiable nonumber norelativenumber signcolumn=no fillchars+=eob:\\ "

		-- Left padding
		vim.cmd("leftabove " .. margin .. "vsplit | enew | " .. side_opts)
		local left_win = vim.api.nvim_get_current_win()

		-- Focus center
		vim.api.nvim_set_current_win(current_win)

		-- Right padding
		vim.cmd("rightbelow " .. margin .. "vsplit | enew | " .. side_opts)
		local right_win = vim.api.nvim_get_current_win()

		side_wins = { left_win, right_win }

		-- Focus active buffer
		vim.api.nvim_set_current_win(current_win)
		vim.g.centered_mode = true
	end
end

vim.keymap.set("n", "<leader>zz", toggle_centered_buffer, { desc = "Toggle Centered Layout" })

-- Compare
-- Enable diff mode for all windows
vim.keymap.set("n", "<leader>bc", ":windo diffthis<CR>", { noremap = true })

-- Disable diff mode for all windows
vim.keymap.set("n", "<leader>bcx", ":windo diffoff<CR>", { noremap = true })

-- Clear search highlighting
vim.keymap.set("n", "<leader>n", ":nohlsearch<CR>", { noremap = true })

-- nvim tree maximizer
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>")

-- telescope
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- Mapping for Shift+Enter to move to the next line in insert mode
vim.keymap.set("i", "<S-Enter>", "<Esc>o", { noremap = true, silent = true })

-- 1. Disable vim-tmux-navigator's automatic mappings so it doesn't send text commands
vim.g.tmux_navigator_no_mappings = 1

-- 2. Normal Mode: Standard Neovim window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })

-- 3. Insert Mode: Keep your existing arrow movement
vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-j>", "<Down>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-k>", "<Up>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true, silent = true })

-- 4. Terminal Mode: Move cursor with arrow keys instead of switching windows
vim.keymap.set("t", "<C-h>", "<Left>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-j>", "<Down>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-k>", "<Up>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-l>", "<Right>", { noremap = true, silent = true })

-- next word and previous word in insert mode
vim.keymap.set("i", "<C-w>", "<Right><C-o>w", { noremap = true })
vim.keymap.set("i", "<C-b>", "<Left><C-o>b", { noremap = true })

-- Terminal mode ("t"): Word movements using escape sequences
vim.keymap.set("t", "<C-b>", "\x1bb", { noremap = true, silent = true }) -- Word backward
vim.keymap.set("t", "<C-w>", "\x1bf", { noremap = true, silent = true }) -- Word forward

-- Terminal exit insert mode
vim.keymap.set("t", "jk", [[<C-\><C-n>]])

-- Wrap
vim.keymap.set("n", "<leader>wr", ":set wrap!<CR>", { noremap = true, silent = true })

-- Move highlited up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Remain cursor where it is
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Allow pasting without copying the deleted text
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Delete and Paste
vim.keymap.set({ "n", "v" }, "<leader>y", [["+ygv<Esc>]])
vim.keymap.set("n", "<leader>Y", [["+Ygv<Esc>]])
vim.keymap.set({ "n", "v" }, "<leader>del", [["_d]])

vim.keymap.set("n", "Q", "<nop>")

-- Esc
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Color toggle
vim.keymap.set("n", "<leader>color", ":ColorizerToggle<CR>")

-- GO DAP
vim.keymap.set("n", "<leader>dt", ':lua require("dapui").toggle()<CR>', { noremap = true, silent = true })
-- vim.keymap.set("n", "<leader>deb", [[<Cmd>lua require('dap-go').debug_test()<CR>]], { noremap = true, silent = true })
vim.keymap.set("n", "<leader>dclear", ':lua require("dap").clear_breakpoints()<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>db", ":DapToggleBreakpoint<CR>", { noremap = true })
vim.keymap.set("n", "<leader>dsp", ':lua require("dap").repl.open({}, "vsplit")<CR>', { noremap = true, silent = true })
-- vim.keymap.set("n", "<leader>dc", ":DapContinue<CR>", { noremap = true })

-- Start debugging
vim.keymap.set("n", "<Leader>dc", ':lua require("dap").continue()<CR>', { noremap = true, silent = true })

-- Stop debugging
vim.keymap.set("n", "<Leader>dd", ':lua require("dap").disconnect()<CR>', { noremap = true, silent = true })

-- Step Into
vim.keymap.set("n", "<Leader>di", ':lua require("dap").step_into()<CR>', { noremap = true, silent = true })

-- Step Over
vim.keymap.set("n", "<Leader>do", ':lua require("dap").step_over()<CR>', { noremap = true, silent = true })

-- Step Out
vim.keymap.set("n", "<Leader>ds", ':lua require("dap").step_out()<CR>', { noremap = true, silent = true })

-- Set a conditional breakpoint in Neovim using DAP
vim.keymap.set(
	"n",
	"<leader>cb",
	[[:lua require('dap').set_breakpoint(vim.fn.input('Condition: '))<CR>]],
	{ noremap = true, silent = true }
)

-- Tab
vim.keymap.set("x", "<Leader>>", ">gv", { noremap = true })
vim.keymap.set("x", "<Leader><", "<gv", { noremap = true })

-- --ZenMode
--
-- vim.keymap.set("n", "<leader>zz", ":ZenMode<CR>", { noremap = true, silent = true })

-- lua require('cmp').setup.buffer { enabled = false }

-- vim.keymap.set("n", "<leader>con", ":lua require('cmp').setup.buffer { enabled = true }<CR>", {})
-- vim.keymap.set("n", "<leader>cof", ":lua require('cmp').setup.buffer { enabled = false }<CR>", {})

local cmp_enabled = true -- Variable to track the state

vim.keymap.set("n", "<leader>cmp", function()
	cmp_enabled = not cmp_enabled
	require("cmp").setup.buffer({ enabled = cmp_enabled })
	print("Completion " .. (cmp_enabled and "enabled" or "disabled"))
end, {})

-- This is for full path
vim.keymap.set("n", "<leader>ffp", ":echo expand('%:p')<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fcfp", function()
	vim.fn.setreg("+", vim.fn.expand("%:p"))
	vim.cmd("echo 'copied: ' .. expand('%:p')")
end, { noremap = true, silent = false })

-- This is for relative path
vim.keymap.set("n", "<leader>fp", ":echo expand('%')<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>cfp", function()
	vim.fn.setreg("+", vim.fn.expand("%"))
	vim.cmd("echo 'copied: ' .. expand('%')")
end, { noremap = true, silent = false })

vim.keymap.set("n", "<leader>rel", function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local current = vim.api.nvim_win_get_option(win, "relativenumber")
		vim.api.nvim_win_set_option(win, "relativenumber", not current)
	end
end, { desc = "Toggle relative number globally" })

--
-- for current buffer only
-- vim.keymap.set("n", "<leader>rel", ":set rnu!<CR>", { desc = "Toggle relative number" })

--
-- vim.keymap.set("n", "<leader>cfl", function()
--   local sdl2_prefix = vim.fn.system("brew --prefix sdl2"):gsub("%s+", "") -- trim newline
--   local include_path = "-I" .. sdl2_prefix .. "/include"
--   vim.fn.writefile({ include_path }, "compile_flags.txt", "a") -- append
--   print("Added: " .. include_path .. " -> compile_flags.txt")
-- end, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>cfl", function()
	vim.cmd('!echo "-I$(brew --prefix sdl2)/include" >> compile_flags.txt')
end, { noremap = true, silent = false, desc = "Add SDL2 include path to compile_flags.txt" })

-- Highlight current line
vim.keymap.set("n", "<leader>hl", function()
	local lnum = vim.fn.line(".") -- get current line number
	vim.fn.matchadd("Search", "\\%" .. lnum .. "l")
end, { desc = "Highlight current line" })

vim.keymap.set("n", "<leader>hf", function()
	require("telescope.builtin").current_buffer_fuzzy_find({
		prompt_title = "Highlight Line",
		attach_mappings = function(_, map)
			map("i", "<CR>", function(prompt_bufnr)
				local entry = require("telescope.actions.state").get_selected_entry()
				require("telescope.actions").close(prompt_bufnr)
				if entry and entry.lnum then
					vim.fn.matchadd("Search", "\\%" .. entry.lnum .. "l")
				end
			end)
			return true
		end,
	})
end, { desc = "Highlight line via Telescope" })

vim.keymap.set("n", "<leader>hn", function()
	local lnum = vim.fn.input("Line to highlight: ")
	if tonumber(lnum) then
		vim.fn.matchadd("Search", "\\%" .. lnum .. "l")
	end
end, { desc = "Highlight specific line" })

vim.keymap.set("n", "<leader>hC", function()
	vim.cmd("call clearmatches()")
end, { desc = "Clear Custom and Search Highlights" })

-- Buffer
-- vim.keymap.set("n", "<Leader>bb", "<C-^>", { noremap = true, silent = true, desc = "Switch to alternative buffer" })
vim.keymap.set("n", "<Leader>bb", function()
	-- switch to alternate buffer (equivalent to <C-^> / :b#)
	vim.cmd("silent! buffer #")
	-- center cursor in the window
	-- vim.cmd("silent! normal! zz")
end, { noremap = true, silent = true, desc = "Switch to alternative buffer and center" })
-- Print the filetype upon enter
-- vim.api.nvim_create_autocmd("WinEnter", {
-- 	callback = function()
-- 		print("WinEnter: ft=" .. tostring(vim.bo.filetype) .. " bt=" .. tostring(vim.bo.buftype))
-- 	end,
-- })
-- Table to store views per buffer (memory only)
local buffer_views = {}

-- Save view when leaving a normal buffer
vim.api.nvim_create_autocmd("BufLeave", {
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		local bt = vim.bo[buf].buftype
		if bt == "" then -- normal file buffers only
			buffer_views[buf] = vim.fn.winsaveview()
		end
	end,
})

-- Restore view when entering a normal buffer
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		local bt = vim.bo[buf].buftype
		if bt == "" and buffer_views[buf] then
			vim.fn.winrestview(buffer_views[buf])
		end
	end,
})

-- Clean up views when buffer is deleted (any method)
vim.api.nvim_create_autocmd("BufDelete", {
	callback = function(opts)
		local buf = opts.buf
		buffer_views[buf] = nil
	end,
})

vim.keymap.set("n", "<leader>bv", function()
	vim.notify(vim.inspect(buffer_views), vim.log.levels.INFO, {
		title = "Buffer Views",
	})
end, { desc = "Show buffer view table" })

-- message
-- Open :messages in a temporary scratch buffer
vim.keymap.set("n", "<leader>m", function()
	local buf = vim.api.nvim_create_buf(false, true)
	local msgs = vim.fn.execute("messages")
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(msgs, "\n"))

	-- Open in a centered floating window
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = math.floor(vim.o.columns * 0.8),
		height = math.floor(vim.o.lines * 0.8),
		col = math.floor(vim.o.columns * 0.1),
		row = math.floor(vim.o.lines * 0.1),
		style = "minimal",
		border = "rounded",
	})
end, { desc = "Show messages in float" })

-- Open command history in a temporary floating scratch buffer
vim.keymap.set("n", "<leader>qf", function()
	-- Create an unlisted scratch buffer
	local buf = vim.api.nvim_create_buf(false, true)

	-- Fetch the command history list
	local history_count = vim.fn.histnr("cmd")
	local history = {}
	for i = 1, history_count do
		local cmd = vim.fn.histget("cmd", i)
		if cmd ~= "" then
			table.insert(history, cmd)
		end
	end

	-- Populate buffer with commands (latest at the bottom)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, history)

	-- Open in a centered floating window
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = math.floor(vim.o.columns * 0.8),
		height = math.floor(vim.o.lines * 0.8),
		col = math.floor(vim.o.columns * 0.1),
		row = math.floor(vim.o.lines * 0.1),
		style = "minimal",
		border = "rounded",
	})

	-- Set buffer options for clean interaction
	vim.bo[buf].filetype = "vim"
	vim.wo[win].cursorline = true

	-- Move cursor to the bottom (most recent command)
	local line_count = vim.api.nvim_buf_line_count(buf)
	vim.api.nvim_win_set_cursor(win, { line_count, 0 })

	-- Pressing <Esc> or q closes the floating window
	local opts = { buffer = buf, silent = true }
	vim.keymap.set("n", "<Esc>", "<cmd>close<CR>", opts)
	vim.keymap.set("n", "q", "<cmd>close<CR>", opts)
end, { desc = "Show command history in float" })
