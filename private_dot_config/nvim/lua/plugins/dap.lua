-- Debug Adapter Protocol (Go via delve)
return {
	{
		'mfussenegger/nvim-dap',
		dependencies = {
			{
				'rcarriga/nvim-dap-ui',
				dependencies = { 'nvim-neotest/nvim-nio' },
				keys = {
					{
						'<leader>du',
						function()
							require('dapui').toggle({})
						end,
						desc = 'DAP UI',
					},
					{
						'<leader>de',
						function()
							require('dapui').eval()
						end,
						desc = 'DAP eval',
						mode = { 'n', 'v' },
					},
				},
				opts = {},
				config = function(_, opts)
					local dap = require('dap')
					local dapui = require('dapui')
					dapui.setup(opts)
					dap.listeners.after.event_initialized['dapui_config'] = function()
						dapui.open({})
					end
					dap.listeners.before.event_terminated['dapui_config'] = function()
						dapui.close({})
					end
					dap.listeners.before.event_exited['dapui_config'] = function()
						dapui.close({})
					end
				end,
			},
			{
				'theHamsta/nvim-dap-virtual-text',
				opts = {},
			},
			{
				'jay-babu/mason-nvim-dap.nvim',
				dependencies = { 'mason-org/mason.nvim' },
				opts = {
					ensure_installed = { 'delve' },
					automatic_installation = true,
				},
			},
			{
				'leoluz/nvim-dap-go',
				opts = {},
			},
		},
		keys = {
			{
				'<leader>db',
				function()
					require('dap').toggle_breakpoint()
				end,
				desc = 'Toggle breakpoint',
			},
			{
				'<leader>dB',
				function()
					require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
				end,
				desc = 'Conditional breakpoint',
			},
			{
				'<leader>dc',
				function()
					require('dap').continue()
				end,
				desc = 'Continue',
			},
			{
				'<leader>di',
				function()
					require('dap').step_into()
				end,
				desc = 'Step into',
			},
			{
				'<leader>do',
				function()
					require('dap').step_over()
				end,
				desc = 'Step over',
			},
			{
				'<leader>dO',
				function()
					require('dap').step_out()
				end,
				desc = 'Step out',
			},
			{
				'<leader>dr',
				function()
					require('dap').repl.toggle()
				end,
				desc = 'Toggle REPL',
			},
			{
				'<leader>dC',
				function()
					require('dap').run_to_cursor()
				end,
				desc = 'Run to cursor',
			},
			{
				'<leader>dj',
				function()
					require('dap').down()
				end,
				desc = 'Down stack',
			},
			{
				'<leader>dk',
				function()
					require('dap').up()
				end,
				desc = 'Up stack',
			},
			{
				'<leader>dl',
				function()
					require('dap').run_last()
				end,
				desc = 'Run last',
			},
			{
				'<leader>dt',
				function()
					require('dap-go').debug_test()
				end,
				desc = 'Debug nearest Go test',
				ft = 'go',
			},
			{
				'<leader>dT',
				function()
					require('dap-go').debug_last_test()
				end,
				desc = 'Debug last Go test',
				ft = 'go',
			},
			{
				'<leader>dx',
				function()
					require('dap').terminate()
				end,
				desc = 'Terminate',
			},
		},
		config = function()
			require('dap-go').setup()
		end,
	},
}
