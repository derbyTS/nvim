return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "jq" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
				terraform = { "terraform_fmt" },
				go = { "gofumpt", "goimports_reviser", "golines" },
				java = { "clang_format" },
				c = { "clang_format_custom_c" },
				cpp = { "clang_format_custom_c" },
			},
			format_on_save = {
				lsp_fallback = false,
				async = false,
				timeout_ms = 1000,
			},
			formatters = {
				clang_format_custom_c = {
					command = "clang-format",
					args = { "--style={BasedOnStyle: LLVM, IndentWidth: 4}" },
				},
				clang_format_custom_cpp = {
					command = "clang-format",
					args = { "--style={BasedOnStyle: Google, IndentWidth: 4}" },
				},
				stylua = {
					command = "stylua",
					args = { "--search-parent-directories", "-" },
					stdin = true,
				},
				goimports_reviser = {
					command = "goimports-reviser",
					args = { "-rm-unused", "-set-alias", "-format" },
				},
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}

-- print current formatter
-- :lua print(vim.inspect(require("conform").list_formatters_for_buffer(0)))
