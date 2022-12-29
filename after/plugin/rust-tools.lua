require("rust-tools").setup()


local lsp_installed, lsp = pcall(require, "lspconfig")
if lsp_installed then
	local function format_on_save(bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.g.AlphaKeks,
			buffer = bufnr,
			callback = vim.lsp.buf.format
		})
	end

	local function apply_keymaps(bufnr)
		vim.keymap.set("n", "<leader><leader>", vim.lsp.buf.hover, { buffer = bufnr })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
		vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, { buffer = bufnr })
		vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { buffer = bufnr })
		vim.keymap.set("n", "gl", vim.diagnostic.open_float, { buffer = bufnr })
		vim.keymap.set("n", "gL", vim.diagnostic.goto_next, { buffer = bufnr })
		vim.keymap.set("n", "gr", function()
			vim.ui.input({ prompt = "New Name: " }, function(input)
				if not input then return end
				vim.lsp.buf.rename(input)
			end)
		end, { buffer = bufnr })
	end

	local capabilities = nil
	local cmp_installed, cmp = pcall(require, "cmp_nvim_lsp")
	if cmp_installed then
		capabilities = cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
	end

	local rust_tools_installed, rust_tools = pcall(require, "rust-tools")
	if rust_tools_installed then
		rust_tools.setup({
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
					format_on_save(bufnr)
					apply_keymaps(bufnr)
				end,
				capabilities = capabilities,
				cmd = { "rustup", "run", "stable", "rust-analyzer" },
				settings = {
					["rust-analyzer"] = {
						checkOnSave = { command = "clippy" }
					}
				}
			}
		})
	end

end
