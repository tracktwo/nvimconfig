return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/nvim-cmp"
        }
    },
    { "rebelot/kanagawa.nvim"  },
    { "nvim-telescope/telescope-fzf-native.nvim" },
    { "numToStr/Comment.nvim", opts = {} },
    { "christoomey/vim-tmux-navigator" },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'codedark'
                }
            })
        end
    },
    { "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
        'saecki/crates.nvim',
        event = { "BufRead Cargo.toml" },
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('crates').setup()
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        config = function()
            require('cmp').setup({})
        end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        config = function()
            local configs = require('nvim-treesitter.configs')
            configs.setup({
                ensure_installed = { "lua", "vim", "vimdoc", "rust" },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = true
                },
                indent = {
                    enable = true
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<Enter>",
                        node_incremental = "<Enter>",
                        node_decremental = "<BS>"
                    }
                }
            })
        end
    },
    {
        'simrat39/symbols-outline.nvim',
        config = function()
            require('symbols-outline').setup()
        end
    }
    ,
    {
        'smoka7/hop.nvim',
        version="*",
        opts = {},
        keys = {
            { 'f', function() require('hop').hint_char1({direction=require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true}) end },
            { 'F', function() require('hop').hint_char1({direction=require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = true}) end },
            { 't', function() require('hop').hint_char1({direction=require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset=-1}) end },
            { 'T', function() require('hop').hint_char1({direction=require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset=-1}) end }
        }
    }
}
