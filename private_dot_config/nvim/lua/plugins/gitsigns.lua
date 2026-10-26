return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'User InGitRepo',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      signs_staged = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 200,
      },
    },
    keys = {
      {
        '<leader>gB',
        function()
          require('gitsigns').blame()
        end,
        desc = 'Git blame (file)',
      },
      {
        '<leader>gb',
        function()
          require('gitsigns').blame_line()
        end,
        desc = 'Git blame line',
      },
      {
        '<leader>gp',
        function()
          require('gitsigns').preview_hunk()
        end,
        desc = 'Preview hunk',
      },
      {
        '<leader>gR',
        function()
          require('gitsigns').reset_hunk()
        end,
        desc = 'Reset hunk',
      },
      {
        ']h',
        function()
          require('gitsigns').nav_hunk('next')
        end,
        desc = 'Next hunk',
      },
      {
        '[h',
        function()
          require('gitsigns').nav_hunk('prev')
        end,
        desc = 'Prev hunk',
      },
    },
  },
}
