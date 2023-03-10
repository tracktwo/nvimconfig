
-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>df', function()
    require('telescope.builtin').lsp_document_symbols({ symbols = "function" })
  end, '[D]ocument [F]unctions')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {
  --   python = { 
  --     analysis = {
  --       logLevel = "Trace",
  --       extraPaths = {"~/Nextcloud/projects/bluet/assistant/homeassistant"}
  --     }
  --   }
  -- },
  -- rust_analyzer = {},
  -- tsserver = {},

  -- pylsp = {
  --   pylsp = {
  --     plugins = {
  --       mccabe = { 
  --         enabled = false
  --       },
  --       pycodestyle = { enabled = false },
  --       pyflakes = { enabled = false } 
  --     }
  --   }
  -- },
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()
--
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}
-- Turn on lsp status information
require('fidget').setup()

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'
local cmpcontext = require 'cmp.config.context'
local lstypes = require 'luasnip.util.types'
local snippet_hl = {
  passive = {
     virt_text = {{"S", "IncSearch"}},
  },
  -- active = {
  --   virt_text = {{"active", "DiffText"}}
  -- },
  -- snippet_passive = {
  --   virt_text = {{"snippet", "DiffText"}}
  -- }
}
-- luasnip setup.
luasnip.config.set_config({
  -- Entering insert mode will leave the current snippet if the cursor
  -- is outside its region. Prevents 'tab' from jumping to a previously
  -- incomplete snippet in another area.
  region_check_events = 'InsertEnter',
  -- Leaving insert mode will check if the snippet was deleted and remove
  -- it from history.
  delete_check_events = 'InsertLeave',

  ext_opts = {
    [lstypes.insertNode] = snippet_hl,
    [lstypes.choiceNode] = snippet_hl,
  }
})
cmp.setup {
  enabled = function()
    -- Disable completion in comments
    return not (cmpcontext.in_treesitter_capture("comment")  or
       cmpcontext.in_syntax_group("comment"))
  end,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-q>'] = cmp.mapping.close,
    ['<C-y>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<C-Space>'] = cmp.mapping.complete,
    ['<Tab>'] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
  experimental = {
    ghost_text = true
  }
}

-- null-ls
local null_ls = require('null-ls')
null_ls.setup({
  sources = {
    -- python
    null_ls.builtins.formatting.black.with({
      extra_args = { "--line-length=80" }
    }),
    null_ls.builtins.formatting.isort,
  }
})

-- rust-tools
local rt = require('rust-tools')

local rust_adapter = function()
  if jit.os == 'Windows' then
    local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.8.1/'
    local codelldb_path = extension_path .. 'adapter/codelldb.exe'
    local liblldb_path = extension_path .. 'lldb/bin/liblldb.dll'
    return require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
  else
    return {
      type = "executable",
      command = "lldb-vscode",
      name = "rt_lldb"
    }
  end
end

rt.setup({
  server = {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>ca", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
    settings = {
      ["rust-analyzer"] = {
        procMacro = { enable = true },
        check = { command = "clippy" },
      }
    }
  },
  dap = {
    adapter = rust_adapter()
  }
})
