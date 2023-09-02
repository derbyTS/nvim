local status, lualine = pcall(require, "lualine")
if not status then
    return
end

-- get default theme
local colorscheme = require("lualine.themes.auto")

-- new colors for theme
local new_colors = {
  EED7DC = "#EED7DC",
  FFCCD1 = "#FFCCD1",
  FF8B99 = "#FF8B99",
  FFDA7B = "#FFCCD1",
  FF3F56 = "#FF3F56",
}


colorscheme.normal.a.bg = new_colors.EED7DC
colorscheme.insert.a.bg = new_colors.FFCCD1
colorscheme.visual.a.bg = new_colors.FF8B99
colorscheme.command = {
  a = {
    gui = "bold",
    bg = new_colors.FF3F56,
    fg = new_colors.black, -- black
  },
}




-- configure lualine with modified theme
lualine.setup({
  options = {
       theme = colorscheme,
  },
})


