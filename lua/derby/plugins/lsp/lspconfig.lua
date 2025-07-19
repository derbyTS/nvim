return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			opts.desc = "Show LSP references Telescope"
			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

			opts.desc = "Go to declaration"
			vim.keymap.set("n", "gD", function()
				-- Save the current buffer silently.
				vim.cmd("silent! w")
				vim.lsp.buf.declaration()
			end, opts)
			-- keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

			opts.desc = "Show LSP definitions (Telescope)"
			-- keymap.set("n", "gDD", require("telescope.builtin").lsp_definitions)
			-- keymap.set("n", "gDD", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions
			keymap.set("n", "gDD", function()
				require("telescope.builtin").lsp_definitions({
					-- Configuration table for lsp_definitions
					-- This 'on_select' function will be called when an item is selected in the picker.
					on_select = function(entry)
						-- Save the current buffer silently before jumping.
						-- The '!' forces the write even if there are minor issues.
						vim.cmd("silent! w")

						-- Close the Telescope picker. `entry.prompt_bufnr` is the buffer number of the picker.
						-- This ensures the picker closes cleanly before we jump to the new location.
						require("telescope.actions").close(entry.prompt_bufnr)

						-- Manually jump to the selected location using Vim commands.
						-- The 'entry' object contains 'filename', 'lnum' (0-indexed line number),
						-- and 'col' (0-indexed column number) from the LSP response.
						-- Vim's `cursor` and `goto` commands are 1-indexed for line numbers,
						-- so we add 1 to `lnum`.
						if entry.filename then
							-- Open the file in the current window.
							vim.cmd(string.format("edit %s", vim.fn.fnameescape(entry.filename)))
							-- Set the cursor position in the new buffer.
							vim.api.nvim_win_set_cursor(0, { entry.lnum + 1, entry.col })
						end
					end,
				})
			end, opts)

			opts.desc = "Show LSP definitions"
			-- keymap.set("n", "gd", vim.lsp.buf.definitions, opts) -- show lsp implementations
			keymap.set("n", "gd", function()
				vim.lsp.buf.definition()
			end, opts)

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation

			opts.desc = "Show LSP implementations Telescope"
			keymap.set("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

			opts.desc = "Show buffer diagnostics"
			-- keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file
			keymap.set("n", "<leader>D", function()
				vim.cmd("Telescope diagnostics bufnr=0")
			end, opts)

			opts.desc = "Show line diagnostics"
			-- keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line
			keymap.set("n", "<leader>d", function()
				vim.diagnostic.open_float()
			end, opts)

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		-- local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		-- for type, icon in pairs(signs) do
		-- 	local hl = "DiagnosticSign" .. type
		-- 	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		-- end

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.INFO] = "",
					[vim.diagnostic.severity.HINT] = "󰠠",
				},
			},
		})

		lspconfig["ansiblels"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["clangd"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				clangd = {
					format = {
						style = "file",
						tabSize = 4,
					},
				},
			},
		})

		lspconfig.cmake.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["bashls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["docker_compose_language_service"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		local util = require("lspconfig/util")
		lspconfig["gopls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl", "gosum" },
			root_dir = util.root_pattern("go.work", "go.mod", "git"),
			settings = {
				gopls = {
					completeUnimported = true,
					usePlaceholders = true,
					analyses = {
						unusedparamas = true,
					},
				},
			},
		})

		lspconfig["bashls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["jsonls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["html"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "tmpl" },
		})

		lspconfig["jdtls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			cmd = { "jdtls" },
			filetypes = { "java" },
			settings = {
				java = {
					classpath = "/Library/Java/JavaVirtualMachines/jdk-18.0.1.1.jdk/",

					formatting = {
						tabSize = 4, -- Adjust this value to your preferred tab size
					},
					completeUnimported = true,
					signatureHelp = { enabled = true }, -- Enable signature help (parameter hints)
					contentProvider = { preferred = "fernflower" }, -- Preferred decompiler for class files
					jdt = {
						completion = {
							overwrite = true, -- Overwrite existing imports when auto-importing
						},
						sources = {
							organizeImports = {
								starThreshold = 9999, -- Specify the number of imports for "import *" to trigger sorting
							},
						},
					},
				},
				editor = {
					tabSize = 4,
				},
			},
		})

		-- lspconfig["marksman"].setup({
		-- 	capabilities = capabilities,
		-- 	on_attach = on_attach,
		-- })

		lspconfig["rust_analyzer"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["sqlls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["yamlls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- lspconfig["ltex"].setup({
		-- 	capabilities = capabilities,
		-- 	on_attach = on_attach,
		-- })

		lspconfig["pyright"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["terraformls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			cmd = { "terraform-ls", "serve" },
			filetypes = { "terraform", "hcl" },
			-- root_dir = lspconfig.util.root_pattern("*.tf", ".terraform", ".git"),
		})
		-- vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
		-- 	pattern = "*.tmpl",
		-- 	callback = function()
		-- 		vim.bo.filetype = "html"
		-- 	end,
		-- })
		-- configure lua server (with special settings)
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})
	end,
}
