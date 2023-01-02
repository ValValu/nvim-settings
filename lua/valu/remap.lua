local mapper = function(mode, key, result) vim.keymap.set(mode, key, result, { noremap = true, silent = true }) end
local no_plugins = require("valu.packer")

-- Essentials
vim.g.mapleader = " " -- set leader to space
mapper("n", "<Leader>no", ":nohl<CR>") -- remove searching highlighting
mapper("n", "<BS>", "daw") -- backspace deletes a word
--mapper("n", "<CR>", ":e<CR>") -- :e loads latest version of file

-- Movement between buffers -> control j etc moves between buffers now
mapper("n", "<C-j>", "<C-w>j")
mapper("n", "<C-h>", "<C-w>h")
mapper("n", "<C-k>", "<C-w>k")
mapper("n", "<C-l>", "<C-w>l")


vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
-- Fugitive

-- Harpoon
local mark = require("harpoon.mark")
local harpoon = require("harpoon.ui")

vim.keymap.set("n", "<leader>A", mark.add_file)
vim.keymap.set("n", "<C-e>", harpoon.toggle_quick_menu)

-- LSP has this in it's own file

--['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--['<C-y>'] = cmp.mapping.confirm({ select = true }),
--["<C-Space>"] = cmp.mapping.complete(),
---- disable completion with tab
---- this helps with copilot setup
--cmp_mappings
--cmp_mappings['<S-Tab>'] = nil
--vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
--vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
--vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

-- // LSP

vim.keymap.set("n", "<leader><leader>", vim.lsp.buf.hover)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "ga", vim.lsp.buf.code_action)
vim.keymap.set("n", "gl", vim.diagnostic.open_float)
vim.keymap.set("n", "gL", vim.diagnostic.goto_next)
vim.keymap.set("n", "gr", function()
vim.ui.input({ prompt = "New Name: " }, function(input)
	if not input then return end
	vim.lsp.buf.rename(input)
	end)
end)

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle) -- toggle undotree

-- vim.keymap.set("n", "<leader>zz", function() --> toggles zen mode

vim.keymap.set("n", "<leader>fv", vim.cmd.Ex) -- open netrw in current files folder

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- in visual mode, J moves line down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- in visual mode, K moves line up

vim.keymap.set("n", "J", "mzJ`z") -- in normal mode J pulls bottom line up
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
mapper("n", "n", "nzzzv")
mapper("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]]) -- replace currently selected text with default register without yanking it

vim.keymap.set({"n", "v"}, "<leader>y", [["+y]]) -- copy selection in V mode
vim.keymap.set("n", "<leader>Y", [["+Y]]) -- copy whole line

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]]) -- delete selection without copying


vim.keymap.set("n", "Q", "<nop>") -- disables
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
--vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("n", "<leader>r", ":!cargo fmt<CR>:!cargo run --bin %:t:r<CR>")
vim.keymap.set("n", "<leader>R", ":!cargo fmt<CR>:!cargo run<CR>")
vim.keymap.set("n", "<leader>t", ":!cargo fmt<CR>>:!cargo nextest run<CR>")


-- Other basics
mapper("n", "<Down>", [["pdd"pp]]) -- move line down
mapper("n", "<Up>", [["pddk"pP]]) -- move line up
mapper("n", "<leader>bn", ":bn<CR>") -- next buffer
mapper("n", "<leader>bp", ":bp<CR>") -- prev buffer
mapper("n", "<leader>bd", ":bp | bd #<CR>") -- delete the current buffer
mapper("n", "+", "=") -- new format mapping

-- Things that require plugins
--mapper("n", "<Leader>nt", ":NvimTreeToggle<CR>") -- toggle file browser in left split
--mapper("n", "<Leader>nf", ":NvimTreeFindFile<CR>") -- open file browser in left split with the current file focused
--mapper("n", "<Leader>nr", ":NvimTreeRefresh<CR>") -- refresh file browser contents
--mapper("n", "<Leader>z", ":call ToggleFocus()<CR>") -- toggle focus on current window
--mapper("n", "<Leader>tn", ":call termcmd#vert()<CR>") -- open new term in vertical split
--mapper("n", "<Leader>ts", ":call termcmd#horiz()<CR>") -- open new term in horizontal split
--mapper("n", "<Leader>ou", "<cmd>AerialToggle!<CR>") -- toggle code outline, powered by tree-sitter

-- Telescope integration
local telescope_builtin = require("telescope.builtin")

mapper("n", "<Leader>ff", telescope_builtin.find_files) -- search all files, respecting .gitignore if one exists
mapper("n", "<Leader>fb", telescope_builtin.buffers) -- search open buffers
mapper("n", "<Leader>fl", telescope_builtin.current_buffer_fuzzy_find) -- search lines in current buffer
mapper("n", "<Leader>gg", telescope_builtin.live_grep) -- search all lines in project
mapper("n", "<Leader>fr", telescope_builtin.lsp_references) -- search references to symbol under cursor
mapper("n", "<Leader>co", telescope_builtin.colorscheme) -- colorschemes
mapper("n", "<Leader>gc", telescope_builtin.git_branches) -- checkout different branches
mapper("n", "<Leader>re", telescope_builtin.git_commits) -- checkout commits; <CR> to checkout, <C-r>[m, s, h] to reset [mixed, soft, hard]
-- jump to items in quickfix list
mapper("n", "<Leader>qf", function()
    -- open picker at bottom of window to match where the quickfix list already is
    telescope_builtin.quickfix(require("telescope.themes").get_ivy())
end)
vim.keymap.set('n', '<leader>ps', function()
    telescope_builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

