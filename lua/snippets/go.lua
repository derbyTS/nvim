local ls = require("luasnip")
local s = ls.snippet
-- local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	s(
		{
			trig = "errdh",
			dscr = "Go error handling pattern: prints error",
		},
		fmt(
			[[
{}, err := {}
if err != nil {{
	log.Fatalln(err)
}}
    ]],
			{
				i(1, "_"), -- cursor lands here first
				i(2, "funcHere"), -- cursor lands here first
			}
		)
	),
	s(
		{
			trig = "errh",
			dscr = "Go error handling pattern: prints error",
		},
		fmt(
			[[
{}, err = {}
if err != nil {{
	log.Fatalln(err)
}}
    ]],
			{
				i(1, "_"), -- cursor lands here first
				i(2, "funcHere"), -- cursor lands here first
			}
		)
	),
	s(
		{
			trig = "errdhh",
			dscr = "Go error handling pattern: prints error and stops execution using return",
		},
		fmt(
			[[
{}, err := {}
if err != nil {{
	log.Fatalln(err)
	return
}}
    ]],
			{
				i(1, "_"), -- cursor lands here first
				i(2, "funcHere"), -- cursor lands here first
			}
		)
	),
	s(
		{
			trig = "errhh",
			dscr = "Go error handling pattern: prints error and stops execution using return",
		},
		fmt(
			[[
{}, err = {}
if err != nil {{
	log.Fatalln(err)
	return
}}
    ]],
			{
				i(1, "_"), -- cursor lands here first
				i(2, "funcHere"), -- cursor lands here first
			}
		)
	),
}

-- return {
-- 	s(
-- 		{
-- 			trig = "errdh",
-- 			dscr = "Go error handling pattern: prints error",
-- 		},
-- 		fmt(
-- 			[[
-- {}, err := {}({})
-- {}, err := {}({})
-- if err != nil {{
-- 	log.Fatalln(err)
-- }}
--     ]],
-- 			{
-- 				i(1, "_"), -- cursor lands here first
-- 				i(2, "funcHere"), -- cursor lands here first
-- 				i(3), -- arguments to the function
-- 			}
-- 		)
-- 	),
-- 	s(
-- 		{
-- 			trig = "errh",
-- 			dscr = "Go error handling pattern: prints error",
-- 		},
-- 		fmt(
-- 			[[
-- {}, err = {}({})
-- if err != nil {{
-- 	log.Fatalln(err)
-- }}
--     ]],
-- 			{
-- 				i(1, "_"), -- cursor lands here first
-- 				i(2, "funcHere"), -- cursor lands here first
-- 				i(3), -- arguments to the function
-- 			}
-- 		)
-- 	),
-- 	s(
-- 		{
-- 			trig = "errdhh",
-- 			dscr = "Go error handling pattern: prints error and stops execution using return",
-- 		},
-- 		fmt(
-- 			[[
-- {}, err := {}({})
-- if err != nil {{
-- 	log.Fatalln(err)
-- 	return
-- }}
--     ]],
-- 			{
-- 				i(1, "_"), -- cursor lands here first
-- 				i(2, "funcHere"), -- cursor lands here first
-- 				i(3), -- arguments to the function
-- 			}
-- 		)
-- 	),
-- 	s(
-- 		{
-- 			trig = "errhh",
-- 			dscr = "Go error handling pattern: prints error and stops execution using return",
-- 		},
-- 		fmt(
-- 			[[
-- {}, err = {}({})
-- if err != nil {{
-- 	log.Fatalln(err)
-- 	return
-- }}
--     ]],
-- 			{
-- 				i(1, "_"), -- cursor lands here first
-- 				i(2, "funcHere"), -- cursor lands here first
-- 				i(3), -- arguments to the function
-- 			}
-- 		)
-- 	),
-- }
