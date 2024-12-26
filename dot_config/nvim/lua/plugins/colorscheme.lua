return {

    {
        "maxmx03/solarized.nvim",
        tag = "v3.6.0",
        lazy = false,
        priority = 1000,
        opts = {
            transparent = {
                enabled = true,
            },
            palette = "selenized"
        },
        config = function(_, opts)
            vim.o.termguicolors = true
            vim.o.background = 'dark'
            require('solarized').setup(opts)
            vim.cmd.colorscheme 'solarized'
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
