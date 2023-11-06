return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-lua/plenary.nvim"
        },
        keys = {
            { '<leader>?', function() require ('telescope.builtin').oldfiles() end, desc = "[?] Find recently opened files" },
            { '<leader><space>', function() require ('telescope.builtin').buffers() end, desc = "[ ] Find existing buffers" },
            { '<leader>f', function() require ('telescope.builtin').find_files() end, desc = "Search [F]iles" },
            { '<leader>sh', function() require ('telescope.builtin').help_tags() end, desc = "[S]earch [H]elp" },
            { '<leader>sw', function() require ('telescope.builtin').grep_strings() end, desc = "[S]earch current [W]ord" },
            { '<leader>g', function() require ('telescope.builtin').live_grep() end, desc = "Search by [G]rep" },
            { '<leader>sd', function() require ('telescope.builtin').diagnostics() end, desc = "[S]earch [D]iagnostics" },
            { '<leader>st', function() require ('telescope.builtin').tagstack() end, desc = "[S]earch [T]agstack" },
            { '<leader>sk', function() require ('telescope.builtin').keymaps() end, desc = "[S]earch [K]eymaps" },
            { '<leader>sr', function() require ('telescope.builtin').registers() end, desc = "[S]earch [R]egisters" },
            { '<leader>b', ":Telescope file_browser<CR>", desc = "[S]earch File [B]rowser" },
            { '<leader>/', function()
                require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false
                }) end, desc = "[/] Fuzzy search in current buffer" },
             --            { '<C-j>', function() require('telescope.actions').move_selection_next() end },
            --{ '<C-k>', function() require('telescope.actions').move_selection_previous() end },
        },
        config = function()
            require('telescope').setup({
                defaults = {
                    path_display = { "truncate" },
                    file_ignore_patterns = {
                        ".git/"
                    },
                },
                pickers = {
                    buffers = {
                        mappings = {
                            n = {
                                ['<M-d>'] = function() require('telescope.actions').delete_buffer() end,
                            },
                            i = {
                                ['<M-d>'] = function() require('telescope.actions').delete_buffer() end,
                            }
                        }
                    },
                    lsp_references = {
                        show_line = false
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
                                ['<C-a>'] = function() require(telescope).extensions.file_browser.actions.create() end,
                            },
                            ["n"] = {
                                 ['<C-a>'] = function() require(telescope).extensions.file_browser.actions.create() end,
                             }
                         }
                     }
                 }
            })
            require('telescope').load_extension "file_browser"
        end
    }
}
