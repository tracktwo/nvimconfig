-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
 require('telescope').setup {
  defaults = {
    path_display = { "truncate" },
    mappings = {
      i = {
        ['<C-j>'] = require('telescope.actions').move_selection_next,
        ['<C-k>'] = require('telescope.actions').move_selection_previous,
      },
    },
  },
  pickers = {
    buffers = {
      mappings = {
        n = {
          ['<M-d>'] = require('telescope.actions').delete_buffer
        },
        i = {
          ['<M-d>'] = require('telescope.actions').delete_buffer,
        },
      },
    },
    lsp_references = {
      show_line = false,
    }
  },
  extensions = {
    file_browser = {
      theme = "ivy",
      hijack_netrw = true,
      display_stat = false,
      path = "%:p:h",
      mappings = {
        ["i"] = {
          ["<C-a>"] = require('telescope').extensions.file_browser.actions.create
        },
        ["n"] = {
          ["<C-a>"] = require('telescope').extensions.file_browser.actions.create
        }
      }
    }
  }
 }

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- Enable telescope file browser
require('telescope').load_extension("file_browser")

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>b', ":Telescope file_browser<CR>", { desc = '[S]earch File [B]rowser' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>f', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>g', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>st', require('telescope.builtin').tagstack, { desc = '[S]earch [T]agstack' })
vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').registers, { desc = '[S]earch [R]egisters' })
