return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		vim.lsp.set_log_level("error")
		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			-- Disable formatting for clangd only
			if client.name == "clangd" then
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end
			opts.buffer = bufnr

			opts.desc = "Show LSP references Telescope"
			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

			-- opts.desc = "Go to declaration"
			-- vim.keymap.set("n", "gD", function()
			-- 	-- Save the current buffer silently.
			-- 	vim.cmd("silent! w")
			-- 	vim.lsp.buf.declaration()
			-- end, opts)
			keymap.set("n", "gdec", vim.lsp.buf.declaration, opts)

			opts.desc = "Show LSP definitions (Telescope)"
			-- keymap.set("n", "gDD", require("telescope.builtin").lsp_definitions)
			-- keymap.set("n", "gDD", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions
			keymap.set("n", "gD", function()
				local has_lsp = vim.lsp.get_clients()[1] ~= nil
				-- local has_lsp = vim.lsp.buf_get_clients()[1] ~= nil
				if has_lsp then
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
				else
					print("LSP not attached")
				end
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

		vim.lsp.config["ansiblels"] = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		vim.lsp.config["clangd"] = {
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
		}

		vim.lsp.config["cmake"] = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		vim.lsp.config["bashls"] = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		vim.lsp.config["docker_compose_language_service"] = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		-- local util = require("lspconfig/util")
		vim.lsp.config["gopls"] = {
			capabilities = capabilities,
			on_attach = on_attach,
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl", "gosum" },
			-- root_dir = util.root_pattern("go.work", "go.mod", "git"),
			root_markers = { "go.work", "go.mod", "git" },
			settings = {
				gopls = {
					completeUnimported = true,
					usePlaceholders = true,
					analyses = {
						unusedparamas = true,
					},
				},
			},
		}

		vim.lsp.config["bashls"] = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		vim.lsp.config["jsonls"] = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		vim.lsp.config["html"] = {
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "tmpl" },
		}

		vim.lsp.config["jdtls"] = {
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
		}

		-- lspconfig["marksman"].setup({
		-- 	capabilities = capabilities,
		-- 	on_attach = on_attach,
		-- })

		vim.lsp.config["rust_analyzer"] = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		vim.lsp.config["sqlls"] = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		vim.lsp.config["yamlls"] = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		-- lspconfig["ltex"].setup({
		-- 	capabilities = capabilities,
		-- 	on_attach = on_attach,
		-- })

		vim.lsp.config["pyright"] = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		vim.lsp.config["terraformls"] = {
			capabilities = capabilities,
			on_attach = on_attach,
			cmd = { "terraform-ls", "serve" },
			filetypes = { "terraform", "hcl" },
			-- root_dir = lspconfig.util.root_pattern("*.tf", ".terraform", ".git"),
		}
		-- vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
		-- 	pattern = "*.tmpl",
		-- 	callback = function()
		-- 		vim.bo.filetype = "html"
		-- 	end,
		-- })
		-- configure lua server (with special settings)
		vim.lsp.config["lua_ls"] = {
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
		}
	end,
}
