
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- This is going to get me cancelled
--vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("n", "<leader>r", ":!cargo fmt<CR>:update<CR>:!cargo run --bin %:t:r<CR>")
vim.keymap.set("n", "<leader>R", ":!cargo fmt<CR>:update<CR>:!cargo run<CR>")
vim.keymap.set("n", "<leader>t", ":!cargo fmt<CR>:update<CR>:!cargo nextest run<CR>")


local mapper = function(mode, key, result) vim.keymap.set(mode, key, result, { noremap = true, silent = true }) end

-- Other basics
mapper("n", "<Down>", [["pdd"pp]]) -- move line down
mapper("n", "<Up>", [["pddk"pP]]) -- move line up
mapper("n", "<Leader>bn", ":bn<CR>") -- next buffer
mapper("n", "<Leader>bp", ":bp<CR>") -- prev buffer
mapper("n", "<Leader>bd", ":bp | bd #<CR>") -- delete the current buffer
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

