return {
	{
		'neovim/nvim-lspconfig',
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = {
			{ 'mason-org/mason.nvim', opts = {} },
			'mason-org/mason-lspconfig.nvim',
			'WhoIsSethDaniel/mason-tool-installer.nvim',
			{ 'j-hui/fidget.nvim', opts = {} },
			'saghen/blink.cmp',
		},
		config = function()
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or 'n'
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
					end

					map('gd', vim.lsp.buf.definition, 'Goto definition')
					map('gD', vim.lsp.buf.declaration, 'Goto declaration')
					map('K', vim.lsp.buf.hover, 'Hover')
					map('gI', require('telescope.builtin').lsp_implementations, 'Goto implementation')
					map('gr', require('telescope.builtin').lsp_references, 'Goto references')
					map('gy', require('telescope.builtin').lsp_type_definitions, 'Goto type definition')
					map('<leader>ca', vim.lsp.buf.code_action, 'Code action')
					map('<leader>cr', vim.lsp.buf.rename, 'Rename')
					map('<leader>cl', '<cmd>LspRestart<cr>', 'Restart LSP')
					map(']d', vim.diagnostic.get_next, 'Next diagnostic')
					map('[d', vim.diagnostic.get_prev, 'Prev diagnostic')
					map('<leader>cd', vim.diagnostic.open_float, 'Line diagnostics')
					map('<leader>ss', require('telescope.builtin').lsp_document_symbols, 'Document symbols')
					map('<leader>sS', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace symbols')
					-- workspace diagnostics: <leader>fd (telescope find group)

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
						local highlight_augroup = vim.api.nvim_create_augroup('user-lsp-highlight', { clear = false })
						vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})
						vim.api.nvim_create_autocmd('LspDetach', {
							group = vim.api.nvim_create_augroup('user-lsp-detach', { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds { group = 'user-lsp-highlight', buffer = event2.buf }
							end,
						})
					end

					if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
						map('<leader>uh', function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
						end, 'Toggle inlay hints')
					end
				end,
			})

			vim.diagnostic.config {
				severity_sort = true,
				float = { border = 'rounded', source = 'if_many' },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = vim.g.have_nerd_font and {
					text = {
						[vim.diagnostic.severity.ERROR] = '󰅚 ',
						[vim.diagnostic.severity.WARN] = '󰀪 ',
						[vim.diagnostic.severity.INFO] = '󰋽 ',
						[vim.diagnostic.severity.HINT] = '󰌶 ',
					},
				} or {},
				virtual_text = { source = 'if_many', spacing = 2 },
			}

			local capabilities = require('blink.cmp').get_lsp_capabilities()

			local servers = {
				gopls = {
					settings = {
						gopls = {
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
							analyses = { unusedparams = true },
							staticcheck = true,
						},
					},
				},
				lua_ls = {
					settings = {
						Lua = {
							completion = { callSnippet = 'Replace' },
						},
					},
				},
			}

			local ensure_installed = vim.tbl_keys(servers)
			vim.list_extend(ensure_installed, {
				'stylua',
				'delve',
				'markdownlint',
				'eslint_d',
			})
			require('mason-tool-installer').setup { ensure_installed = ensure_installed }

			require('mason-lspconfig').setup {
				ensure_installed = {},
				automatic_installation = false,
			}

			for server, cfg in pairs(servers) do
				cfg.capabilities = vim.tbl_deep_extend('force', {}, capabilities, cfg.capabilities or {})
				vim.lsp.config(server, cfg)
				vim.lsp.enable(server)
			end
		end,
	},
}
