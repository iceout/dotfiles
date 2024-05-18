return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
      }
    }
  },

  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "pyright",
        "lua_ls",
        "gopls",
      }
    }
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require('lspconfig')
      lspconfig.pyright.setup {
        settings = {
          python = {
            analysis = {
              autoSearchPaths = false,
            },
          },
        },
      }
      lspconfig.lua_ls.setup({})
      lspconfig.gopls.setup({})
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            ensure_installed = {
              "c",
              "bash",
              "html",
              "javascript",
              "lua",
              "json",
              "markdown",
              "markdown_inline",
              "python",
              "tsx",
              "typescript",
              "yaml",
            },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
  },
}
