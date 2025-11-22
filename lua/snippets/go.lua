local ls = require("luasnip")
local s = ls.snippet
-- local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	s(
		"errh",
		fmt(
			[[
{}, err := {}({})
if err != nil {{
	fmt.Println(err)
	return
}}
    ]],
			{
				i(1, "_"), -- cursor lands here first
				i(2, "funcHere"), -- cursor lands here first
				i(3), -- arguments to the function
			}
		)
	),
}
