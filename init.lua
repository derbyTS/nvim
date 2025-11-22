require("derby.core.options")
require("derby.core.keymaps")
require("derby.core.trailingwhitespace")
require("derby.lazy")

-- Load LuaSnip
require("luasnip.loaders.from_lua").lazy_load({
	paths = vim.fn.stdpath("config") .. "/lua/snippets",
})
