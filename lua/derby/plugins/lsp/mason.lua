return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"tsserver",
				"html",
				"cssls",
				"tailwindcss",
				"lua_ls",
				"emmet_ls",
				"ansiblels",
				"bashls",
				"docker_compose_language_service",
				"gopls",
				"jsonls",
				"jdtls",
				"marksman",
				"pyright",
				"rust_analyzer",
				"sqlls",
				"yamlls",
			},
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true, -- not the same as ensure_installed
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- ts/js formatter
				"stylua", -- lua formatter
				"eslint_d", -- ts/js linter
				"clang-format",
				"sonarlint-language-server",
				"golines",
				"gofumpt",
				"goimports-reviser",
				"golines",
			},
		})
	end,
}
