# Neovim v0.12 Environment Installation Guide (macOS ARM64)

Complete setup guide for replicating this Neovim v0.12 environment on a fresh Apple Silicon Mac running Zsh.

---

## 1. Core Tooling & Dependency Setup

### Step 1: Install Homebrew & Load Shell Environment

Open Terminal (Zsh) and install Homebrew:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Add Homebrew to your Zsh environment profile:

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
source ~/.zshrc
```

_Verification:_ Run `which brew`. It must return `/opt/homebrew/bin/brew`.

---

### Step 2: Install Neovim & Development Dependencies

Install Neovim, Tree-sitter CLI, Node.js (required for Markdown preview server), and compiler toolchains:

```bash
brew install neovim tree-sitter-cli node git ripgrep fd
```

_Verification:_ Run `which tree-sitter`. It must return `/opt/homebrew/bin/tree-sitter`.

---

## 2. Configuration & Plugin Installation

### Step 1: Clone Your Neovim Configuration

Clone your dotfiles into the Neovim configuration directory:

```bash
git clone <YOUR_DOTFILES_REPO_URL> ~/.config/nvim
```

---

### Step 2: Configure Plugins

Ensure your plugin configurations match these exact specifications:

#### `lua/config/lazy.lua`

```lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  rocks = {
    enabled = false, -- Disables Luarocks warnings
  },
})
```

#### `lua/plugins/treesitter.lua`

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
    require("nvim-treesitter.install").prefer_git = true

    local ok, configs = pcall(require, "nvim-treesitter.configs")
    if ok then
      configs.setup({
        highlight = { enable = true },
        indent = { enable = true },
        autotag = { enable = true },
        ensure_installed = {
          "comment", "json", "javascript", "typescript", "tsx", "yaml",
          "html", "css", "markdown", "markdown_inline", "svelte", "graphql",
          "bash", "lua", "vim", "dockerfile", "gitignore", "java", "go",
          "gomod", "gowork", "gosum", "rust", "latex", "hcl",
        },
      })
    end
  end,
}
```

#### `lua/plugins/markdown.lua`

```lua
return {
  -- In-buffer live syntax rendering
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {},
    ft = { "markdown" },
  },
  -- Browser-based live preview server
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_browser = "open"
    end,
  },
}
```

---

## 3. First Boot & Verification Checklist

1. **Launch Neovim to download plugins:**

   ```bash
   nvim
   ```

   `lazy.nvim` will automatically trigger and clone all plugins.

2. **Verify System Health:**
   Inside Neovim, execute:

   ```vim
   :checkhealth
   ```

   _Expectation:_ Zero errors for `nvim-treesitter`, `lazy`, and `vim.lsp`.

3. **Verify Treesitter Parsers:**

   ```vim
   :TSUpdate
   ```

4. **Verify Markdown Browser Preview:**
   Open any `.md` file in Neovim and run:
   ```vim
   :MarkdownPreview
   ```
   _Expectation:_ Your browser launches automatically with the live document preview.
