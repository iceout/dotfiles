return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
      ensure_installed = {
      },
      automatic_installation = true,
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "ruff",
        "lua_ls",
        "gopls",
        "bashls",
      },
      automatic_installation = true,
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      -- 获取 Neovim LSP 客户端的默认功能列表
      -- 如果你使用 nvim-cmp，可以替换为: require('cmp_nvim_lsp').default_capabilities()
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- ===================================================================
      --   在这里配置你的语言服务器
      --   使用 vim.lsp.config(server_name, options)
      -- ===================================================================

      -- Ruff (Python)
      vim.lsp.config('ruff', {
        capabilities = capabilities,
        trace = "messages",
        init_options = {
          settings = {
            logLevel = "debug",
            enable = false,
          },
        },
      })

      -- Lua
      vim.lsp.config('lua_ls', {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      -- Go
      vim.lsp.config('gopls', {
        capabilities = capabilities,
      })

      -- Bash
      vim.lsp.config('bashls', {
        capabilities = capabilities,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = {
          "c",
          "bash",
          "go",
          "gotmpl",
          "html",
          "javascript",
          "json",
          "lua",
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
        fold = { enable = true },
      })
    end,
  },

  {
    "folke/trouble.nvim",
    tag = "v3.7.1",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
    config = function()
      require("trouble").setup {
        position = "bottom", -- 列表显示的位置：bottom, top, left, right
      }
    end
  },
}
