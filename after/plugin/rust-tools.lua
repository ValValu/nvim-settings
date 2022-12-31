local rt = require("rust-tools")
rt.setup({
			tools = {
				inlay_hints = {
					auto = true,
					only_current_line = false,
					show_parameter_hints = true
				}
			},
			server = {
				standalone = true,
                on_attach = function(_, bufnr)
                    vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                    vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
                end,
				cmd = { "rustup", "run", "stable", "rust-analyzer" },
				settings = {
					["rust-analyzer"] = {
						checkOnSave = { command = "clippy" }
					}
				}
			}
		})

