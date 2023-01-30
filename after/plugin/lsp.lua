local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'sumneko_lua',
  'pyright',
  'rust_analyzer',
})

-- Fix Undefined global 'vim'
lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            },
        }
    }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})



lsp.on_attach(function(client, bufnr)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})

