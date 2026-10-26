-- Create a single augroup for all autocommands
local core_group = vim.api.nvim_create_augroup('core_autocmds', { clear = true })

-- highlight yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = core_group,
  pattern = '*',
  desc = 'Highlight selection on yank',
  callback = function()
    vim.highlight.on_yank { timeout = 200, visual = true }
  end,
})

-- restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd('BufReadPost', {
  group = core_group,
  desc = 'Restore cursor position',
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
      -- defer centering slightly so it's applied after render
      vim.schedule(function()
        vim.cmd 'normal! zz'
      end)
    end
  end,
})

-- open help in vertical split
vim.api.nvim_create_autocmd('FileType', {
  group = core_group,
  pattern = 'help',
  command = 'wincmd L',
})

-- auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd('VimResized', {
  group = core_group,
  command = 'wincmd =',
})

-- no auto continue comments on new line
vim.api.nvim_create_autocmd('FileType', {
  group = core_group,
  desc = 'Disable auto-commenting',
  callback = function()
    vim.opt_local.formatoptions:remove { 'c', 'r', 'o' }
  end,
})

-- syntax highlighting for dotenv files
vim.api.nvim_create_autocmd('BufRead', {
  group = core_group,
  pattern = { '.env', '.env.*' },
  desc = 'Set filetype for dotenv files',
  callback = function()
    vim.bo.filetype = 'dosini'
  end,
})

-- Go: tabs, width 4 (gofmt); overrides global expandtab/shiftwidth=2
vim.api.nvim_create_autocmd('FileType', {
  group = core_group,
  pattern = 'go',
  desc = 'Go indentation',
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

-- show cursorline only in active window
vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
  group = core_group,
  desc = 'Enable cursorline in active window',
  callback = function()
    vim.opt_local.cursorline = true
  end,
})

vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave' }, {
  group = core_group,
  desc = 'Disable cursorline in inactive window',
  callback = function()
    if vim.api.nvim_get_current_win() ~= 0 then
      vim.opt_local.cursorline = false
    end
  end,
})

-- ide-like highlight when stopping cursor
vim.api.nvim_create_autocmd('CursorMoved', {
  group = core_group,
  desc = 'Highlight references under cursor',
  callback = function()
    -- Skip if no LSP clients are attached
    if not next(vim.lsp.get_clients { bufnr = 0 }) then
      return
    end

    -- Only run if the cursor is not in insert mode
    if vim.fn.mode() ~= 'i' then
      local clients = vim.lsp.get_clients { bufnr = 0 }
      local supports_highlight = false
      for _, client in ipairs(clients) do
        if client.server_capabilities.documentHighlightProvider then
          supports_highlight = true
          break -- Found a supporting client, no need to check others
        end
      end

      -- 3. Proceed only if an LSP is active AND supports the feature
      if supports_highlight then
        vim.lsp.buf.clear_references()
        vim.lsp.buf.document_highlight()
      end
    end
  end,
})

vim.api.nvim_create_autocmd('CursorMovedI', {
  group = core_group,
  desc = 'Clear highlights when entering insert mode',
  callback = function()
    vim.lsp.buf.clear_references()
  end,
})
