return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  opts = {
    indent = {
      char = '▏',
    },
    scope = {
      show_start = false,
      show_end = false,
      show_exact_scope = false,
    },
    exclude = {
      filetypes = {
        'help',
        'startify',
        'dashboard',
        'packer',
        'neogitstatus',
        'NvimTree',
        'neo-tree',
        'Trouble',
      },
    },
  },
}
