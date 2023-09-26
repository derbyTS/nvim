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

-- Compare
-- Enable diff mode for all windows
vim.keymap.set("n", "<leader>bc", ":windo diffthis<CR>", { noremap = true })

-- Disable diff mode for all windows
vim.keymap.set("n", "<leader>bcx", ":windo diffoff<CR>", { noremap = true })

-- Clear search highlighting
vim.keymap.set("n", "<leader>n", ":nohlsearch<CR>", { noremap = true })

--
vim.keymap.set("n", "<leader>se", ":MaximizerToggle<CR>")

-- nvim tree maximizer
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- telescope
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- Mapping for Shift+Enter to move to the next line in insert mode
vim.keymap.set("i", "<S-Enter>", "<Esc>o", { noremap = true, silent = true })

-- Custom mappings for left and right navigation in insert mode
vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-k>", "<Up>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-j>", "<Down>", { noremap = true, silent = true })

-- next word and previous word in insert mode
vim.keymap.set("i", "<C-w>", "<Right><C-o>w", { noremap = true })
vim.keymap.set("i", "<C-b>", "<Left><C-o>b", { noremap = true })

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
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
