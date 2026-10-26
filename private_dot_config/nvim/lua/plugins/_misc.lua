-- Standalone plugins with little config
return {
	{
		-- Needed early for Ctrl-h/j/k/l with tmux
		'christoomey/vim-tmux-navigator',
		lazy = false,
	},
	{
		'tpope/vim-sleuth',
		event = { 'BufReadPost', 'BufNewFile' },
	},
	{
		'folke/lazydev.nvim',
		ft = 'lua',
		opts = {
			library = {
				{ path = '${3rd}/luv/library', words = { 'vim%.uv' } },
			},
		},
	},
	{
		'folke/which-key.nvim',
		event = 'VeryLazy',
		opts = {
			spec = {
				{ '<leader>f', group = 'find' },
				{ '<leader>s', group = 'search' },
				{ '<leader>b', group = 'buffer' },
				{ '<leader>c', group = 'code' },
				{ '<leader>g', group = 'git' },
				{ '<leader>d', group = 'debug' },
				{ '<leader>u', group = 'ui' },
				{ '<leader>m', group = 'move' },
				{ '<leader>q', group = 'quit' },
				{ '<leader><tab>', group = 'tabs' },
			},
		},
	},
	{
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		config = true,
		opts = {},
	},
	{
		'numToStr/Comment.nvim',
		event = { 'BufReadPost', 'BufNewFile' },
		dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
		config = function()
			require('Comment').setup({
				pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
			})
		end,
	},
	{
		'folke/todo-comments.nvim',
		event = { 'BufReadPost', 'BufNewFile' },
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = { signs = false },
	},
}
