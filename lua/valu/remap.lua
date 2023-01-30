local mapper = function(mode, key, result) vim.keymap.set(mode, key, result, { noremap = true, silent = true }) end
local opts = { noremap = true }

-- Essentials
vim.g.mapleader = " " -- set leader to space
mapper("n", "<Leader>no", ":nohl<CR>") -- remove searching highlighting
mapper("n", "<BS>", "daw") -- backspace deletes a word

vim.keymap.set("n", "<leader>gs", vim.cmd.Git)


-- window management
vim.keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
vim.keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

vim.keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
vim.keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
vim.keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

vim.keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization


-- Harpoon
local mark = require("harpoon.mark")
local harpoon = require("harpoon.ui")

vim.keymap.set("n", "<leader>A", mark.add_file)
vim.keymap.set("n", "<C-e>", harpoon.toggle_quick_menu)

-- LSP

vim.keymap.set("n", "<leader><leader>", vim.lsp.buf.hover)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "ga", vim.lsp.buf.code_action)
vim.keymap.set("n", "gl", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
vim.keymap.set("n", "<leader>q", function() vim.lsp.buf.format() end, opts)
vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
vim.keymap.set("n", "<leader>wr", function() vim.lsp.buf.references() end, opts)
vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
vim.keymap.set("n", "gr", function()
    vim.ui.input({ prompt = "New Name: " }, function(input)
        if not input then return end
        vim.lsp.buf.rename(input)
    end)
end)

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle) -- toggle undotree

vim.keymap.set("n", "<leader>zz", function()
    require("zen-mode").toggle()
    vim.wo.wrap = false
end)

vim.keymap.set("n", "<leader>fv", vim.cmd.Ex) -- open netrw in current files folder

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- in visual mode, J moves line down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- in visual mode, K moves line up

vim.keymap.set("n", "J", "mzJ`z") -- in normal mode J pulls bottom line up
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
mapper("n", "n", "nzzzv")
mapper("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]]) -- replace currently selected text with default register without yanking it

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]]) -- copy selection in V mode
vim.keymap.set("n", "<leader>Y", [["+Y]]) -- copy whole line

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]]) -- delete selection without copying


vim.keymap.set("n", "Q", "<nop>") -- disables
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
--vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("n", "<leader>r", ":!cargo fmt<CR>:!cargo run --bin %:t:r<CR>")
vim.keymap.set("n", "<leader>R", ":!cargo fmt<CR>:!cargo run<CR>")
vim.keymap.set("n", "<leader>t", ":!cargo fmt<CR>>:!cargo nextest run %:t:r<CR>")
vim.keymap.set("n", "<leader>T", ":!cargo fmt<CR>>:!cargo nextest run<CR>")
mapper("n", "<F12>", ":w<CR>:!python3 %:t:r.py<CR>")

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
mapper("n", "<Leader>ou", "<cmd>AerialToggle!<CR>") -- toggle code outline, powered by tree-sitter

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

vim.keymap.set("i", "<C-a>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
