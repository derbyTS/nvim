local opt = vim.opt --for conciseness

--
vim.opt.fileformat = "unix" -- LF
-- vim.opt.fileformat = "mac" -- CR
-- vim.opt.fileformat = "dos" -- CRLF

-- line numbers

opt.relativenumber = true
opt.number = true

-- tabs and indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = false
opt.autoindent = true

-- vim.cmd("highlight ExtraWhitespace ctermbg=1 guibg=#EED7DC")
-- vim.cmd("match ExtraWhitespace /\\s\\+$/")

-- Set different tab settings for C files using LSP
-- vim.cmd([[
--     augroup C_LSP_TabSettings
--         autocmd!
--         autocmd FileType c,cpp lua vim.opt.tabstop = 2
--         autocmd FileType c,cpp lua vim.opt.shiftwidth = 2
--         autocmd FileType c,cpp lua vim.opt.expandtab = true
--     augroup END
-- ]])

-- vim.cmd([[
--   autocmd FileType c setlocal tabstop=2 shiftwidth=2
--   autocmd FileType cpp setlocal tabstop=2 shiftwidth=2
--   autocmd FileType java setlocal tabstop=2 shiftwidth=2
-- ]])

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- appearance
opt.termguicolors = true
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")

-- Search
-- opt.hlsearch = false
opt.incsearch = true
-- opt.termguicolors = true

opt.scrolloff = 8
