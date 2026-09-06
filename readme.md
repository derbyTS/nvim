# Neovim v0.12 Environment Setup & Migration Changelog

## Executive Summary

This document logs the diagnostic journey, configuration updates, and structural changes required to achieve a fully healthy, high-performance Neovim v0.12.5 environment on macOS (ARM64 / Apple Silicon).

---

## 1. Issues & Hindrances Encountered

### A. Tree-sitter ABI Version Mismatch (LaTeX Parser Error)

- **Symptom**: `thread 'main' panicked at cli/generate/src/render.rs: This version of Tree-sitter can only generate parsers with ABI version 13 - 14, not 15`.
- **Root Cause**: Modern language parsers (like LaTeX) require Tree-sitter ABI v15. The system had an outdated global binary installed at `/usr/local/bin/tree-sitter` (version `0.24.7`), which was taking PATH precedence over the Homebrew installation.
- **Resolution**:
  1. Removed the old Intel/Rosetta binary at `/usr/local/bin/tree-sitter`. `sudo rm -f /usr/local/bin/tree-sitter` and `rehash`. Check which tree-sitter is active `which tree-sitter`.
  2. Installed the official `tree-sitter-cli` package via Homebrew (`brew install tree-sitter-cli`), upgrading to `v0.27.0`.
  3. Prepend `/opt/homebrew/bin` to `vim.env.PATH` inside Neovim config to guarantee proper binary discovery.(You don't need to add it to lazy.lua because mason.nvim and your Zsh shell are doing it for you automatically.).

### B. Broken Zsh PATH & Missing CLI Binary

- **Symptom**: `zsh: command not found: tree-sitter` despite `tree-sitter` formula being installed.
- **Root Cause**: The standalone `tree-sitter` Homebrew formula on macOS ARM64 supplies libraries, whereas the command-line interface tool is provided by `tree-sitter-cli`.
- **Resolution**: Installed `tree-sitter-cli` directly and loaded `/opt/homebrew/bin/brew shellenv` into `.zshrc`. (`brew install tree-sitter-cli
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
source ~/.zshrc`
  )

### C. CSV Query Health Check Error

- **Symptom**: `:checkhealth nvim-treesitter` flagged `❌ ERROR csv(queries):`.
- **Root Cause**: Corrupted or mismatched query files left over from prior parser downloads.
- **Resolution**: Ran `:TSUpdate` followed by `:TSInstall! csv` to synchronize parser definitions and compiled C libraries.

### D. LuaRocks / Hererocks Health Check Errors

- **Symptom**: `lazy.nvim` threw `❌ ERROR .../hererocks/bin/luarocks not installed`.
- **Root Cause**: Incomplete local Hererocks installation environment within `lazy.nvim` data directory.
- **Resolution**: Explicitly disabled built-in rocks management in `lazy.nvim` options (`rocks = { enabled = false }`) since no installed plugins required LuaRocks C-bindings.

### E. Disappearing `:LspInfo` / `:LspRestart` Commands

- **Symptom**: Executing `:LspInfo` or `:LspRestart` returned `E492: Not an editor command`.
- **Root Cause**:
  1. Neovim v0.11/v0.12 native LSP client reorganization shifted diagnostic checks to `:checkhealth vim.lsp`.
  2. `nvim-lspconfig` lazy-loading (`BufReadPre`) prevents custom LSP commands from existing before a file buffer is opened.

---

## 2. Updated Configurations

### `lua/plugins/treesitter.lua` (`lazy.nvim` spec)

```lua
return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"windwp/nvim-ts-autotag",
	},
	config = function()
		-- Force downloading pre-compiled C source files to bypass CLI generation mismatches
		require("nvim-treesitter.install").prefer_git = true

		local ok, configs = pcall(require, "nvim-treesitter.configs")
		if ok then
			configs.setup({
				highlight = { enable = true },
				indent = { enable = true },
				autotag = { enable = true },
				ensure_installed = {
					"comment",
					"json",
					"javascript",
					"typescript",
					"tsx",
					"yaml",
					"html",
					"css",
					"markdown",
					"markdown_inline",
					"svelte",
					"graphql",
					"bash",
					"lua",
					"vim",
					"dockerfile",
					"gitignore",
					"java",
					"go",
					"gomod",
					"gowork",
					"gosum",
					"rust",
					"latex",
					"hcl",
				},
			})
		end
	end,
}
```
