vim.g.mapleader = "," -- Make sure to set `mapleader` before lazy so your mappings are correct

-- Hint: use `:h <option>` to figure out the meaning if needed
vim.opt.clipboard = 'unnamedplus' -- use system clipboard
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.mouse = 'a'               -- allow the mouse to be used in Nvim

-- Tab
vim.opt.tabstop = 4      -- number of visual spaces per TAB
vim.opt.softtabstop = 4  -- number of spacesin tab when editing
vim.opt.shiftwidth = 4   -- insert 4 spaces on a tab
vim.opt.expandtab = true -- tabs are spaces, mainly because of python

-- UI config
vim.opt.number = true         -- show absolute number
vim.opt.relativenumber = true -- add numbers to each line on the left side
vim.opt.cursorline = true     -- highlight cursor line underneath the cursor horizontally
vim.opt.splitbelow = true     -- open new vertical split bottom
vim.opt.splitright = true     -- open new horizontal splits right
-- vim.opt.termguicolors = true        -- enabl 24-bit RGB color in the TUI
vim.opt.showmode = false      -- we are experienced, wo don't need the "-- INSERT --" mode hint

-- Searching
vim.opt.incsearch = true  -- search as characters are entered
vim.opt.hlsearch = false  -- do not highlight matches
vim.opt.ignorecase = true -- ignore case in searches by default
vim.opt.smartcase = true  -- but make it case sensitive if an uppercase is entered

--Folding
vim.opt.foldcolumn = "2"
vim.opt.foldlevel = 90
--vim.opt.foldmethod = "expr"
vim.api.nvim_exec([[
  augroup filetype_folding
    autocmd!
    autocmd FileType * setlocal foldmethod=indent
    autocmd FileType c,go,gotmpl,html,javascript,json,lua,markdown,python,sh,tsx,typescript,yaml setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()
  augroup END
]], false)

-- vim.api.nvim_exec([[
--   autocmd BufEnter * silent! lcd %:p:h
-- ]], false)
-- 自动设置目录为文件所在目录
--vim.api.nvim_create_autocmd('BufEnter', {
--    command = "silent! lcd %:p:h",
--})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
    callback = function()
        require("lint").try_lint()
    end,
})

