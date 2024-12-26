return {
    {
        "smoka7/hop.nvim",
        tag = "^2",
        keys = {
            { "<leader>h", "<Cmd>HopWord<CR>", mode = "n", silent = true },
            { "<leader>H", "<Cmd>HopLine<CR>", mode = "n", silent = true },
            -- {'f', '<Cmd>HopWordCurrentLine<CR>', mode = 'n', silent = true},
            {
                "f",
                function()
                    require("hop").hint_char1({
                        direction = require("hop.hint").HintDirection.AFTER_CURSOR,
                        current_line_only = true,
                    })
                end,
                desc = "Find line",
            },
            {
                "F",
                function()
                    require("hop").hint_char1({
                        direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
                        current_line_only = true,
                    })
                end,
                desc = "Find line",
            },
        },
        config = function()
            require("hop").setup()
        end,
    },
}
