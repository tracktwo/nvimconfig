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
}
