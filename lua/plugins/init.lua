return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer"
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
}
