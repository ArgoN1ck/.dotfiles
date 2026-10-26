-- Leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local map = vim.keymap.set

map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Keep delete char out of clipboard
map('n', 'x', '"_x')

-- Scroll / search centered
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- Clear search highlight
map({ 'i', 'n' }, '<Esc>', '<cmd>noh<cr><esc>')

-- Indent stay in visual
map('x', '<', '<gv')
map('x', '>', '>gv')

-- Wrapped lines
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move lines (no Alt — conflicts with AeroSpace ⌥j/⌥k)
map('n', '<leader>mj', "<cmd>execute 'move .+' . v:count1<cr>==", { desc = 'Move line down' })
map('n', '<leader>mk', "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = 'Move line up' })
map('v', '<leader>mj', ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = 'Move selection down' })
map('v', '<leader>mk', ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = 'Move selection up' })

-- Insert
map('i', 'jj', '<Esc>')

-- Save / quit
map('n', '<leader>w', '<cmd>w<cr>', { desc = 'Save', silent = true })
map('n', '<leader>W', '<cmd>noautocmd w<cr>', { desc = 'Save without autocmd', silent = true })
map('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit all' })
map('n', '<leader>qQ', '<cmd>qa!<cr>', { desc = 'Quit all without saving' })

-- Buffers (avoid <Tab> — it collides with <C-i> jumplist in terminals)
map('n', ']b', '<cmd>bnext<cr>', { desc = 'Next buffer' })
map('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev buffer' })
map('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next buffer' })
map('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev buffer' })
map('n', '<leader>bd', '<cmd>Bdelete<cr>', { desc = 'Delete buffer' })
map('n', '<leader>bn', '<cmd>enew<cr>', { desc = 'New buffer' })
map('n', '<leader>bo', '<cmd>BufferLineCloseOthers<cr>', { desc = 'Close other buffers' })

-- Splits (Ctrl-h/j/k/l owned by vim-tmux-navigator)
map('n', '<leader>|', '<cmd>vsplit<cr>', { desc = 'Split vertical' })
map('n', '<leader>-', '<cmd>split<cr>', { desc = 'Split horizontal' })

-- Tabs
map('n', '<leader><tab>o', '<cmd>tabonly<cr>', { desc = 'Close other tabs' })
map('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'New tab' })
map('n', '<leader><tab>d', '<cmd>tabclose<cr>', { desc = 'Close tab' })

-- Spell
map('n', '<leader>us', function()
	vim.opt_local.spell = not vim.opt_local.spell:get()
	vim.notify('spell: ' .. tostring(vim.opt_local.spell:get()))
end, { desc = 'Toggle spell' })
