return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		-- Snippets
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
		"onsails/lspkind.nvim",
		"roobert/tailwindcss-colorizer-cmp.nvim",
	},
	config = function()
		local lspkind = require("lspkind")
		local colorizer = require("tailwindcss-colorizer-cmp").formatter

		local autoformat_filetypes = {
			"lua",
		}
		-- Create a keymap for vim.lsp.buf.implementation
		-- vim.api.nvim_create_autocmd("LspAttach", {
		--   callback = function(args)
		--     local client = vim.lsp.get_client_by_id(args.data.client_id)
		--     if not client then
		--       return
		--     end
		--     if vim.tbl_contains(autoformat_filetypes, vim.bo.filetype) then
		--       vim.api.nvim_create_autocmd("BufWritePre", {
		--         buffer = args.buf,
		--         callback = function()
		--           vim.lsp.buf.format({
		--             formatting_options = { tabSize = 2, insertSpaces = true },
		--             bufnr = args.buf,
		--             id = client.id,
		--           })
		--         end,
		--       })
		--     end
		--   end,
		-- })

		-- LSP handlers with borders
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1d2021", fg = "#ebdbb2" })
		vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#1d2021", fg = "#665c54" })
		-- vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { link = "Pmenu" })

		-- Set borders for LSP hover and signature help
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "rounded", -- You can also use "single", "double", "solid", etc.
			focusable = false,
		})

		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
			border = "rounded",
			focusable = false,
		})

		-- Configure diagnostics
		vim.diagnostic.config({
			virtual_text = false,
			underline = true,
			update_in_insert = true,
			float = {
				border = "single",
				style = "minimal",
				header = "",
				prefix = "",
			},
			signs = false, -- disables signs in the gutter
		})
		-- NOTE: temp disable
		-- signs = {
		-- 	text = {
		-- 		[vim.diagnostic.severity.ERROR] = "✘",
		-- 		[vim.diagnostic.severity.WARN] = "▲",
		-- 		[vim.diagnostic.severity.HINT] = "⚑",
		-- 		[vim.diagnostic.severity.INFO] = "»",
		-- 	},
		-- },

		-- Add cmp_nvim_lsp capabilities settings to lspconfig

		-- This should be executed before you configure any language server
		local lspconfig_defaults = require("lspconfig").util.default_config
		lspconfig_defaults.capabilities = vim.tbl_deep_extend(
			"force",
			lspconfig_defaults.capabilities,
			require("cmp_nvim_lsp").default_capabilities()
		)

		-- This is where you enable features that only work
		-- if there is a language server active in the file
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(event)
				local opts = { buffer = event.buf }
				vim.keymap.set("n", "K", function()
					vim.lsp.buf.hover({
						border = "single",
					})
				end, opts)
				vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
				vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
				vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
				vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
				vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
				vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
				vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
				vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
				vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
				vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
			end,
		})

		require("mason").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"intelephense",
				"gopls",
				"ts_ls",
				"eslint",
			},
			handlers = {
				-- this first function is the "default handler"
				-- it applies to every language server without a custom handler
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,

				-- this is the "custom handler" for `lua_ls`
				lua_ls = function()
					require("lspconfig").lua_ls.setup({
						settings = {
							Lua = {
								runtime = {
									version = "LuaJIT",
								},
								diagnostics = {
									globals = { "vim" },
								},
								workspace = {
									library = { vim.env.VIMRUNTIME },
								},
							},
						},
					})
				end,
			},
		})

		local cmp = require("cmp")

		local lsp_kinds = {
			Class = " ",
			Color = " ",
			Constant = " ",
			Constructor = " ",
			Enum = " ",
			EnumMember = " ",
			Event = " ",
			Field = " ",
			File = " ",
			Folder = " ",
			Function = " ",
			Interface = " ",
			Keyword = " ",
			Method = " ",
			Module = " ",
			Operator = " ",
			Property = " ",
			Reference = " ",
			Snippet = " ",
			Struct = " ",
			Text = " ",
			TypeParameter = " ",
			Unit = " ",
			Value = " ",
			Variable = " ",
		}

		require("luasnip.loaders.from_vscode").lazy_load()

		vim.opt.completeopt = { "menu", "menuone", "noselect" }

		cmp.setup({
			preselect = "item",
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			window = {
				completion = cmp.config.window.bordered({
					border = "single",
					winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
					scrollbar = true,
				}),
				documentation = cmp.config.window.bordered({
					border = "single",
					winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
				}),
			},
			sources = {
				{ name = "luasnip", keyword_length = 2 },
				{ name = "nvim_lsp" },
				{ name = "buffer", keyword_length = 3 },
				{ name = "path" },
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			formatting = {
				fields = { "abbr", "menu", "kind" },
				format = function(entry, item)
					-- local n = entry.source.name
					-- if n == "nvim_lsp" then
					-- 	item.menu = "[LSP]"
					-- else
					-- 	item.menu = string.format("[%s]", n)
					-- end
					-- return item

					item.kind = string.format("%s %s", lsp_kinds[item.kind], item.kind)
					item.menu = ({
						buffer = "[Buffer]",
						nvim_lsp = "[LSP]",
						luasnip = "[Luasnip]",
						nvim_lua = "[Lua]",
						latex_symbols = "[LaTeX]",
					})[entry.source.name]

					item = lspkind.cmp_format({
						maxwidth = 30,
						ellipses_char = "...",
					})(entry, item)

					if entry.source.name == "nvim_lsp" then
						item = colorizer(entry, item)
					end

					return item
				end,
			},
			mapping = cmp.mapping.preset.insert({
				-- confirm completion item
				["<CR>"] = cmp.mapping.confirm({ select = false }),

				-- scroll documentation window
				["<C-f>"] = cmp.mapping.scroll_docs(5),
				["<C-u>"] = cmp.mapping.scroll_docs(-5),

				-- toggle completion menu
				["<C-e>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.abort()
					else
						cmp.complete()
					end
				end),

				-- tab complete
				["<Tab>"] = cmp.mapping(function(fallback)
					local col = vim.fn.col(".") - 1

					if cmp.visible() then
						cmp.select_next_item({ behavior = "select" })
					elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
						fallback()
					else
						cmp.complete()
					end
				end, { "i", "s" }),

				-- go to previous item
				["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = "select" }),

				-- navigate to next snippet placeholder
				["<C-d>"] = cmp.mapping(function(fallback)
					local luasnip = require("luasnip")

					if luasnip.jumpable(1) then
						luasnip.jump(1)
					else
						fallback()
					end
				end, { "i", "s" }),

				-- navigate to the previous snippet placeholder
				["<C-b>"] = cmp.mapping(function(fallback)
					local luasnip = require("luasnip")

					if luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
		})
	end,
}
--
-- return {
-- 	-- Main LSP Configuration
-- 	"neovim/nvim-lspconfig",
-- 	dependencies = {
-- 		-- Automatically install LSPs and related tools to stdpath for Neovim
-- 		-- Mason must be loaded before its dependents so we need to set it up here.
-- 		-- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
-- 		{ "mason-org/mason.nvim", opts = {} },
-- 		"mason-org/mason-lspconfig.nvim",
-- 		"WhoIsSethDaniel/mason-tool-installer.nvim",
--
-- 		-- Useful status updates for LSP.
-- 		{ "j-hui/fidget.nvim", opts = {} },
--
-- 		-- -- Allows extra capabilities provided by blink.cmp
-- 		"saghen/blink.cmp",
-- 	},
-- 	config = function()
-- 		-- Brief aside: **What is LSP?**
-- 		--
-- 		-- LSP is an initialism you've probably heard, but might not understand what it is.
-- 		--
-- 		-- LSP stands for Language Server Protocol. It's a protocol that helps editors
-- 		-- and language tooling communicate in a standardized fashion.
-- 		--
-- 		-- In general, you have a "server" which is some tool built to understand a particular
-- 		-- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
-- 		-- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
-- 		-- processes that communicate with some "client" - in this case, Neovim!
-- 		--
-- 		-- LSP provides Neovim with features like:
-- 		--  - Go to definition
-- 		--  - Find references
-- 		--  - Autocompletion
-- 		--  - Symbol Search
-- 		--  - and more!
-- 		--
-- 		-- Thus, Language Servers are external tools that must be installed separately from
-- 		-- Neovim. This is where `mason` and related plugins come into play.
-- 		--
-- 		-- If you're wondering about lsp vs treesitter, you can check out the wonderfully
-- 		-- and elegantly composed help section, `:help lsp-vs-treesitter`
--
-- 		--  This function gets run when an LSP attaches to a particular buffer.
-- 		--    That is to say, every time a new file is opened that is associated with
-- 		--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
-- 		--    function will be executed to configure the current buffer
-- 		vim.api.nvim_create_autocmd("LspAttach", {
-- 			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
-- 			callback = function(event)
-- 				-- NOTE: Remember that Lua is a real programming language, and as such it is possible
-- 				-- to define small helper and utility functions so you don't have to repeat yourself.
-- 				--
-- 				-- In this case, we create a function that lets us more easily define mappings specific
-- 				-- for LSP related items. It sets the mode, buffer and description for us each time.
-- 				local map = function(keys, func, desc, mode)
-- 					mode = mode or "n"
-- 					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
-- 				end
--
-- 				-- Rename the variable under your cursor.
-- 				--  Most Language Servers support renaming across files, etc.
-- 				map("<leader>cr", vim.lsp.buf.rename, "[R]e[n]ame")
--
-- 				-- Execute a code action, usually your cursor needs to be on top of an error
-- 				-- or a suggestion from your LSP for this to activate.
-- 				map("<leader>ca", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
--
-- 				-- Find references for the word under your cursor.
-- 				map("<leader>gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
--
-- 				-- Jump to the implementation of the word under your cursor.
-- 				--  Useful when your language has ways of declaring types without an actual implementation.
-- 				map("<leader>gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
--
-- 				-- Jump to the definition of the word under your cursor.
-- 				--  This is where a variable was first declared, or where a function is defined, etc.
-- 				--  To jump back, press <C-t>.
-- 				map("<leader>gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
--
-- 				-- WARN: This is not Goto Definition, this is Goto Declaration.
-- 				--  For example, in C this would take you to the header.
-- 				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
--
-- 				-- Fuzzy find all the symbols in your current document.
-- 				--  Symbols are things like variables, functions, types, etc.
-- 				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
--
-- 				-- Fuzzy find all the symbols in your current workspace.
-- 				--  Similar to document symbols, except searches over your entire project.
-- 				map("<leader>", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
--
-- 				-- Jump to the type of the word under your cursor.
-- 				--  Useful when you're not sure what type a variable is and you want to see
-- 				--  the definition of its *type*, not where it was *defined*.
-- 				map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")
--
-- 				-- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
-- 				---@param client vim.lsp.Client
-- 				---@param method vim.lsp.protocol.Method
-- 				---@param bufnr? integer some lsp support methods only in specific files
-- 				---@return boolean
-- 				local function client_supports_method(client, method, bufnr)
-- 					if vim.fn.has("nvim-0.11") == 1 then
-- 						return client:supports_method(method, bufnr)
-- 					else
-- 						return client.supports_method(method, { bufnr = bufnr })
-- 					end
-- 				end
--
-- 				-- The following two autocommands are used to highlight references of the
-- 				-- word under your cursor when your cursor rests there for a little while.
-- 				--    See `:help CursorHold` for information about when this is executed
-- 				--
-- 				-- When you move your cursor, the highlights will be cleared (the second autocommand).
-- 				local client = vim.lsp.get_client_by_id(event.data.client_id)
-- 				if
-- 					client
-- 					and client_supports_method(
-- 						client,
-- 						vim.lsp.protocol.Methods.textDocument_documentHighlight,
-- 						event.buf
-- 					)
-- 				then
-- 					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
-- 					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
-- 						buffer = event.buf,
-- 						group = highlight_augroup,
-- 						callback = vim.lsp.buf.document_highlight,
-- 					})
--
-- 					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
-- 						buffer = event.buf,
-- 						group = highlight_augroup,
-- 						callback = vim.lsp.buf.clear_references,
-- 					})
--
-- 					vim.api.nvim_create_autocmd("LspDetach", {
-- 						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
-- 						callback = function(event2)
-- 							vim.lsp.buf.clear_references()
-- 							vim.api.nvim_clear_autocmds({
-- 								group = "kickstart-lsp-highlight",
-- 								buffer = event2.buf,
-- 							})
-- 						end,
-- 					})
-- 				end
--
-- 				-- The following code creates a keymap to toggle inlay hints in your
-- 				-- code, if the language server you are using supports them
-- 				--
-- 				-- This may be unwanted, since they displace some of your code
-- 				if
-- 					client
-- 					and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
-- 				then
-- 					map("<leader>th", function()
-- 						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
-- 					end, "[T]oggle Inlay [H]ints")
-- 				end
-- 			end,
-- 		})
--
-- 		-- Diagnostic Config
-- 		-- See :help vim.diagnostic.Opts
-- 		vim.diagnostic.config({
-- 			severity_sort = true,
-- 			float = { border = "rounded", source = "if_many" },
-- 			underline = { severity = vim.diagnostic.severity.ERROR },
-- 			signs = {
-- 				text = {
-- 					[vim.diagnostic.severity.ERROR] = "󰅚 ",
-- 					[vim.diagnostic.severity.WARN] = "󰀪 ",
-- 					[vim.diagnostic.severity.INFO] = "󰋽 ",
-- 					[vim.diagnostic.severity.HINT] = "󰌶 ",
-- 				},
-- 			},
-- 			virtual_text = {
-- 				source = "if_many",
-- 				spacing = 2,
-- 				format = function(diagnostic)
-- 					local diagnostic_message = {
-- 						[vim.diagnostic.severity.ERROR] = diagnostic.message,
-- 						[vim.diagnostic.severity.WARN] = diagnostic.message,
-- 						[vim.diagnostic.severity.INFO] = diagnostic.message,
-- 						[vim.diagnostic.severity.HINT] = diagnostic.message,
-- 					}
-- 					return diagnostic_message[diagnostic.severity]
-- 				end,
-- 			},
-- 		})
--
-- 		-- LSP servers and clients are able to communicate to each other what features they support.
-- 		--  By default, Neovim doesn't support everything that is in the LSP specification.
-- 		--  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
-- 		--  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
-- 		local original_capabilities = vim.lsp.protocol.make_client_capabilities()
-- 		local capabilities = require("blink.cmp").get_lsp_capabilities()
--
-- 		-- Enable the following language servers
-- 		--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
-- 		--
-- 		--  Add any additional override configuration in the following tables. Available keys are:
-- 		--  - cmd (table): Override the default command used to start the server
-- 		--  - filetypes (table): Override the default list of associated filetypes for the server
-- 		--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
-- 		--  - settings (table): Override the default settings passed when initializing the server.
-- 		--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
-- 		local servers = {
-- 			-- clangd = {},
-- 			marksman = {},
-- 			gopls = {},
-- 			-- pyright = {},
-- 			-- rust_analyzer = {},
-- 			-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
-- 			--
-- 			-- Some languages (like typescript) have entire language plugins that can be useful:
-- 			--    https://github.com/pmizio/typescript-tools.nvim
-- 			--
-- 			-- But for many setups, the LSP (`ts_ls`) will work just fine
-- 			ts_ls = {},
-- 			--
--
-- 			lua_ls = {
-- 				-- cmd = { ... },
-- 				-- filetypes = { ... },
-- 				-- capabilities = {},
-- 				-- settings = {
-- 				--   Lua = {
-- 				--     completion = {
-- 				--       callSnippet = 'Replace',
-- 				--     },
-- 				--     -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
-- 				--     -- diagnostics = { disable = { 'missing-fields' } },
-- 				--   },
-- 				-- },
-- 			},
-- 		}
--
-- 		-- Ensure the servers and tools above are installed
-- 		--
-- 		-- To check the current status of installed tools and/or manually install
-- 		-- other tools, you can run
-- 		--    :Mason
-- 		--
-- 		-- You can press `g?` for help in this menu.
-- 		--
-- 		-- `mason` had to be setup earlier: to configure its options see the
-- 		-- `dependencies` table for `nvim-lspconfig` above.
-- 		--
-- 		-- You can add other tools here that you want Mason to install
-- 		-- for you, so that they are available from within Neovim.
-- 		local ensure_installed = vim.tbl_keys(servers or {})
-- 		vim.list_extend(ensure_installed, {
-- 			"stylua", -- Used to format Lua code
-- 		})
-- 		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
--
-- 		require("mason-lspconfig").setup({
-- 			ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
-- 			automatic_installation = false,
-- 			handlers = {
-- 				function(server_name)
-- 					local server = servers[server_name] or {}
-- 					-- This handles overriding only values explicitly passed
-- 					-- by the server configuration above. Useful when disabling
-- 					-- certain features of an LSP (for example, turning off formatting for ts_ls)
-- 					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
-- 					require("lspconfig")[server_name].setup(server)
-- 				end,
-- 			},
-- 		})
-- 	end,
-- }
