return {
    {
        'VonHeikemen/lsp-zero.nvim', branch='v3.x',
        dependencies = {
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'j-hui/fidget.nvim',
            'folke/neodev.nvim',
            'L3MON4D3/LuaSnip',
            'simrat39/rust-tools.nvim',
        },
        config = function()
            local lsp_zero = require('lsp-zero')
            lsp_zero.on_attach(function(client,bufnr)
                lsp_zero.default_keymaps({buffer=bufnr})
            end)

            vim.g.rustfmt_autosave = 1

            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = {},
                handlers = {
                    lsp_zero.default_setup,
                    rust_analyzer = function()
                        local rust_tools = require('rust-tools')
                        rust_tools.setup({
                            server = {
                                on_attach = function(client, bufnr)
                                    vim.keymap.set('n', '<leader>ca', rust_tools.hover_actions.hover_actions, {buffer=bufnr})
                                    vim.keymap.set('n', '<leader>ca', rust_tools.code_action_group.code_action_group, {buffer=bufnr})
                                end,
                                settings = {
                                    ["rust-analyzer"] = {
                                        procMacro = { enable = true },
                                        check = { command = "clippy" },
                                    }
                                }
                            }
                        })
                    end
                }
            })
        end
    }
}

