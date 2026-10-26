return {
  'saghen/blink.cmp',
  version = '*',
  event = 'InsertEnter',
  dependencies = {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    config = function()
      local ls = require 'luasnip'
      ls.config.set_config {
        updateevents = 'TextChanged,TextChangedI',
      }
      require('luasnip.loaders.from_lua').lazy_load {
        paths = '~/.config/nvim/snippets/',
      }
    end,

  },
  opts = {
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
    },
    snippets = { preset = 'luasnip' },
    completion = {
      trigger = {
        show_on_keyword = true,
      },
      accept = {
        auto_brackets = { enabled = true },
      },
      list = { max_items = 30 },
      menu = {
        border = 'none',
        draw = {
          columns = { { 'label', 'label_description', gap = 1 }, { 'kind' } },
          components = {
            label = {
              width = {
                fill = true,
              },
              text = function(ctx)
                return ctx.label .. ctx.label_detail
              end,
              highlight = function(ctx)
                -- label and label details
                local highlights = {
                  { 0, #ctx.label, group = ctx.deprecated and 'BlinkCmpLabelDeprecated' or 'BlinkCmpLabel' },
                }
                if ctx.label_detail then
                  table.insert(highlights, { #ctx.label, #ctx.label + #ctx.label_detail, group = 'BlinkCmpLabelDetail' })
                end

                -- characters matched on the label by the fuzzy matcher
                for _, idx in ipairs(ctx.label_matched_indices) do
                  table.insert(highlights, { idx, idx + 1, group = 'BlinkCmpLabelMatch' })
                end

                return highlights
              end,
            },
            label_description = {
              -- width = { max = 30 },
              text = function(ctx)
                return ctx.label_description
              end,
              highlight = 'BlinkCmpLabelDescription',
            },
            source_name = {
              text = function(ctx)
                return ctx.source_name or ''
              end, -- Display the source name
              highlight = 'BlinkCmpSource',
            },
          },
        },
      },
      documentation = {
        window = { border = 'single' },
      },
    },
    sources = {
      default = { 'lazydev', 'lsp', 'snippets', 'path' },
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
      },
    },
    cmdline = { enabled = false }, -- Disable complition in cmd mode
    signature = {
      enabled = true,
      window = { border = 'single' },
    },
    keymap = {
      ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
      ['<Tab>'] = { 'select_next', 'fallback' },
      ['<Esc>'] = { 'hide', 'fallback' },
      preset = 'enter',
    },
  },
}
