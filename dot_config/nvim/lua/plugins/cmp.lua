return {
	-- snippet
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		event = "InsertEnter",
		dependencies = {
			{
				{ "saadparwaiz1/cmp_luasnip" },
				{
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load()
						require("luasnip.loaders.from_vscode").load({ paths = { "./my-snippets" } })
					end,
				},
			},
		},
		keys = {
			{
				"<C-j>",
				function()
					return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<space>"
				end,
				expr = true,
				silent = true,
				mode = "i",
			},
			{
				"<C-j>",
				function()
					require("luasnip").jump(1)
				end,
				mode = "s",
			},
			{
				"<C-k>",
				function()
					require("luasnip").jump(-1)
				end,
				mode = { "i", "s" },
			},
		},
	},

	-- completion
	-- TODO: setup for formatting
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			local source_mapping = {
				nvim_lsp = "[LSP]",
				luasnip = "[Snippet]",
				buffer = "[Buffer]",
				treesitter = "[TreeSitter]",
				path = "[Path]",
			}

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "treesitter" },
					{ name = "path" },
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = "symbol" })
						vim_item.menu = source_mapping[entry.source.name]
						local maxwidth = 80
						vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
						return vim_item
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-l>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
				}),
			})
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
					{ name = "cmdline" },
				}),
			})
		end,
	},

	{
		"robitx/gp.nvim",
		config = function()
			local config = {
				providers = {
					openai = {
						endpoint = "https://api.deepseek.com/chat/completions",
						secret = { "cat", "/home/zhangxuanyi/deepseek" },
					},
				},
				agents = {
					{
						name = "Deepseek-coder",
						chat = false,
						command = true,
						-- string with model name or table with model name and parameters
						model = { model = "deepseek-coder" },
						-- system prompt (use this to specify the persona/role of the AI)
						system_prompt = "You are an AI working as a code editor.\n\n"
							.. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
							.. "START AND END YOUR ANSWER WITH:\n\n```",
					},
				},
				chat_topic_gen_model = "deepseek-chat",
			}
			require("gp").setup(config)
		end,
	},
}
