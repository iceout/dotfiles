vim.g.mapleader = "," -- Make sure to set `mapleader` before lazy so your mappings are correct

-- Hint: use `:h <option>` to figure out the meaning if needed
vim.opt.clipboard = 'unnamedplus' -- use system clipboard
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.mouse = "a"               -- allow the mouse to be used in Nvim

-- Tab
vim.opt.tabstop = 4      -- number of visual spaces per TAB
vim.opt.softtabstop = 4  -- number of spacesin tab when editing
vim.opt.shiftwidth = 4   -- insert 4 spaces on a tab
vim.opt.expandtab = true -- tabs are spaces, mainly because of python

vim.opt.list = true
vim.opt.listchars = {
  tab = '→ ', -- 显示制表符为箭头
  trail = '·', -- 显示行尾空格
  extends = '⟩', -- 显示被折叠的文本
  precedes = '⟨', -- 显示被折叠的文本
}

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
vim.opt.hlsearch = true   -- do not highlight matches
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
-- vim.api.nvim_create_autocmd('BufEnter', {
--   command = "silent! lcd %:p:h",
-- })


-- flake8 python file
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePre" }, {
  pattern = "*.py",
  callback = function()

    local lint = require("lint")
    lint.try_lint()
    -- 使用 defer_fn 延迟执行检查诊断结果的逻辑
    vim.defer_fn(function()
      -- 获取当前诊断信息的数量
      local trouble = require("trouble")
      local count = #vim.diagnostic.get(0)
      if count > 0 then
        if not trouble.is_open("diagnostics") then -- 如果 Trouble 没有打开，则打开它
          trouble.toggle("diagnostics")            -- 打开 Trouble 面板
        end
      else
        if trouble.is_open("diagnostics") then
          trouble.close("diagnostics") -- 关闭 Trouble 面板
        end
      end
    end, 300) -- 延迟 300 毫秒
  end,
})
-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePre" }, {
--   pattern = "*.py",
--   callback = function()
--     -- 定义 root_files 和查找根目录的函数
--     local root_files = {
--       "pyproject.toml",
--       ".git", -- 你可以根据需要添加其他标识项目根目录的文件
--     }
--     -- 查找项目根目录
--     local root_dir = (function()
--       return vim.fs.root(0, root_files)
--     end)()
--
--     local lint = require("lint")
--     if root_dir and vim.fn.filereadable(root_dir .. "/pyproject.toml") == 1 then
--       -- 配置 flake8 使用 pyproject.toml 作为配置文件
--       -- 自定义 flake8 参数，传递 pyproject.toml 的路径
--       lint.linters.flake8.args = {
--         "--config", root_dir .. "/pyproject.toml", -- 动态传递 pyproject.toml 的路径
--       }
--       lint.try_lint()
--     else
--       lint.try_lint()
--     end
--     -- 使用 defer_fn 延迟执行检查诊断结果的逻辑
--     vim.defer_fn(function()
--       -- 获取当前诊断信息的数量
--       local trouble = require("trouble")
--       local count = #vim.diagnostic.get(0)
--       if count > 0 then
--         if not trouble.is_open("diagnostics") then -- 如果 Trouble 没有打开，则打开它
--           trouble.toggle("diagnostics")            -- 打开 Trouble 面板
--         end
--       else
--         if trouble.is_open("diagnostics") then
--           trouble.close("diagnostics") -- 关闭 Trouble 面板
--         end
--       end
--     end, 300) -- 延迟 300 毫秒
--   end,
-- })
