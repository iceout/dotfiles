local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- "tanvirtin/monokai.nvim",
    "shaunsingh/solarized.nvim",
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
})
