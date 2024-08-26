return {

	{
		"maxmx03/solarized.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local solarized = require("solarized")
			vim.o.background = "dark" -- or 'light'
			solarized.setup({
				transparent = true,
				palette = "selenized", -- or solarized
				--  colors = {
				--    base0 = "#b9b9b9",
				--    base02 = "#3b3b3b",
				--    base03 = "#181818",
				--    base04 = "#252525",
				--    magenta = "#eb6eb7",
				--    red = "#ed4a46",
				--    yellow = "#dbb32d",
				--    green = "#70b433",
				--    blue = "#368aeb",
				--    cyan = "#3fc5b7",
				--  },
			})
			vim.cmd.colorscheme("solarized")
		end,
	},

	-- {
	--     "olimorris/onedarkpro.nvim",
	--     priority = 1000, -- Ensure it loads first
	--     config = function()
	--         local onedarkpro = require("onedarkpro")
	--         onedarkpro.setup({
	--             -- colors = {
	--             --   red = "#b9b9b9"
	--             -- },
	--             options = {
	--                 transparency = true,
	--             },
	--         })
	--         vim.cmd.colorscheme("onedark")
	--     end
	-- },

	-- {
	-- 	"navarasu/onedark.nvim",
	-- 	priority = 1000, -- Ensure it loads first
	-- 	config = function()
	-- 		local onedark = require("onedark")
	-- 		onedark.setup({
	-- 			transparent = true,
	-- 		})
	-- 		vim.cmd.colorscheme("onedark")
	-- 	end,
	-- },
}
