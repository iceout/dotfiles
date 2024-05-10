return {
    {
        'smoka7/hop.nvim',
        branch = 'v2',
        keys = {
            {'<leader>h', '<Cmd>HopWord<CR>', mode = 'n', silent = true},
            {'<leader>H', '<Cmd>HopLine<CR>', mode = 'n', silent = true},
            {'<leader>f', '<Cmd>HopWordCurrentLine<CR>', mode = 'n', silent = true},
        },
        config = function()
            require('hop').setup()
        end
    },
}
