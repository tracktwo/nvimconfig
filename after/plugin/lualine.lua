
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'nightfly',
    component_separators = '',
    section_separators = '',
  },
  sections = {
    lualine_b = {
      'branch',
      -- {
      --   'diff',
      -- },
      'diagnostics'
    },
    lualine_c = {
      {
        'filetype',
        colored = true,
        icon_only = true,
        icon = { align = 'right' },
        padding = { left = (vim.o.columns - 40) / 2, right = 0 },
      },
      {
        'filename',
        path = 1,
      },
    },
    lualine_x = {
    }
  }
}

