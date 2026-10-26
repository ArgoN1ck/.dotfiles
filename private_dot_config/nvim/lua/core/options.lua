local o = vim.opt

-- General settings
o.number = true -- Show line numbers
o.relativenumber = true -- Relative line numbers
o.mouse = 'a' -- Enable mouse support
o.clipboard = 'unnamedplus' -- Use system clipboard
o.swapfile = false -- Disable swap files

-- Performance
o.updatetime = 300 -- Faster completion
o.timeoutlen = 500 -- Shorter timeout for keymaps

-- Appearance
o.termguicolors = true -- Enable true colors
o.signcolumn = 'yes' -- Always show sign column
o.scrolloff = 10 -- Keep 10 lines visible around the cursor

-- Search
o.ignorecase = true -- Ignore case in search
o.smartcase = true -- Override ignorecase if uppercase is used
o.incsearch = true -- Incremental search

-- Indentation
o.expandtab = true
o.smartindent = true
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2

-- UI / behavior
o.wrap = false
o.cursorline = true
o.confirm = true
o.smoothscroll = true

-- Fillchars
o.fillchars = {
  vert = '│',
  fold = '⠀',
  eob = ' ', -- suppress ~ at EndOfBuffer
  -- diff = "⣿", -- alternatives = ⣿ ░ ─ ╱
  msgsep = '‾',
  foldopen = '▾',
  foldsep = '│',
  foldclose = '▸',
}
