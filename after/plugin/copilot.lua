vim.g.copilot_no_tab_map = true
vim.keymap.set(
    "i",
    "<Plug>(vimrc:copilot-dummy-map)",
    'copilot#Accept("")',
    { silent = true, expr = true, desc = "Copilot dummy accept" }
)

local cmp = require("cmp")
cmp.setup {
  mapping = {
    ['<M-a>'] = cmp.mapping(function(fallback)
      vim.api.nvim_feedkeys(vim.fn['copilot#Accept'](vim.api.nvim_replace_termcodes('<Tab>', true, true, true)), 'n', true)
    end)
  },
}
