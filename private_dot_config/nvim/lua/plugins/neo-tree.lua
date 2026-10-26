-- File explorer: Files / Buffers / Git
-- Validated against neo-tree v3 defaults + per-source commands.
return {
	'nvim-neo-tree/neo-tree.nvim',
	branch = 'v3.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-tree/nvim-web-devicons',
		'MunifTanjim/nui.nvim',
	},
	cmd = 'Neotree',
	keys = {
		{ '<leader>e', '<cmd>Neotree toggle position=left<cr>', desc = 'Explorer' },
		{ '<leader>gs', '<cmd>Neotree float git_status<cr>', desc = 'Git status' },
	},
	opts = {
		close_if_last_window = true,
		enable_git_status = true,
		enable_diagnostics = true,
		sources = { 'filesystem', 'buffers', 'git_status' },
		source_selector = {
			winbar = true,
			statusline = false,
			sources = {
				{ source = 'filesystem', display_name = ' 󰉓 Files ' },
				{ source = 'buffers', display_name = ' 󰈚 Buffers ' },
				{ source = 'git_status', display_name = ' 󰊢 Git ' },
			},
		},
		default_component_configs = {
			indent = {
				with_expanders = true,
				expander_collapsed = '',
				expander_expanded = '',
			},
		},
		window = {
			width = 32,
			mappings = {
				['<space>'] = 'none', -- don't steal leader
				-- switch Files / Buffers / Git (default < and >; made explicit)
				['<'] = 'prev_source',
				['>'] = 'next_source',
				-- vim-like navigation (overrides default l = focus_preview)
				['h'] = 'close_node',
				['l'] = 'open',
				['z'] = 'close_all_nodes',
				['Z'] = 'expand_all_nodes',
			},
		},
		filesystem = {
			follow_current_file = { enabled = true },
			hijack_netrw_behavior = 'open_default',
			filtered_items = {
				hide_dotfiles = false,
				hide_gitignored = true,
			},
			window = {
				mappings = {
					-- H = toggle_hidden (default). Do NOT map "." — default "." is set_root.
					['H'] = 'toggle_hidden',
					['/'] = 'fuzzy_finder',
					['<C-x>'] = 'clear_filter',
					['<bs>'] = 'navigate_up',
					-- filesystem-only (invalid on buffers/git_status if put in window.mappings)
					['[g'] = 'prev_git_modified',
					[']g'] = 'next_git_modified',
				},
			},
		},
		buffers = {
			follow_current_file = { enabled = true },
			window = {
				mappings = {
					['d'] = 'buffer_delete', -- not file delete
				},
			},
		},
		git_status = {
			window = {
				mappings = {
					['A'] = 'git_add_all',
					['gu'] = 'git_unstage_file',
					['ga'] = 'git_add_file',
					['gr'] = 'git_revert_file',
					['gc'] = 'git_commit',
					['gp'] = 'git_push',
				},
			},
		},
	},
}
