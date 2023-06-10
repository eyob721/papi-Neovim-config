-- We use M to export
-- On M we define the functions LSP setup, on_attach and capabilities
local M = {}

-- Use protected call to check if cmp_nvim_lsp is available
local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

-- This function is called from the init.lua file of the lsp directory
-- It is used to setup the LSP
M.setup = function()
	local signs = {

		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in pairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = false, -- disable virtual text
		signs = {
			active = signs, -- show signs
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			-- style = "minimal",
			border = "rounded",
			source = "always",
			-- header = "",
			-- prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

-- -----------------------------------------------------------------------
-- Define the capabilities
-- -----------------------------------------------------------------------
M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)
-- -----------------------------------------------------------------------

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)	-- Jumps to the declaration of the symbol under the cursor
	keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)		-- Jumps to the definition of the symbol under the cursor.
	keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)			--  Displays hover information about the symbol under the cursor in a floating window
	keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)	-- Lists all the implementations for the symbol under the cursor in the quickfix window.
	keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)		-- Lists all the references to the symbol under the cursor in the quickfix window.
	keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)	-- Show diagnostics in a floating window.
	keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)	-- Formats a buffer using the attached (and optionally filtered) language server clients.
	-- keymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)						-- opens LspInstallInfo -- doesn't work 
	keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)									-- opens LspInfo
	keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)			-- Selects a code action available at the current cursor position.
	keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)	-- Move to the next diagnostic.
	keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)	-- Move to the previous diagnostic.
	keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)					-- Renames all references to the symbol under the cursor.
	keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)			-- Displays signature information about the symbol under the cursor in a floating window.
	keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)			-- Add buffer diagnostics to the location list.
end

-- -----------------------------------------------------------------------
-- Define the on_attach function
-- -----------------------------------------------------------------------
M.on_attach = function(client, bufnr)
	-- if client.name == "tsserver" then
	-- 	client.server_capabilities.documentFormattingProvider = false
	-- end

	-- if client.name == "sumneko_lua" then
	-- 	client.server_capabilities.documentFormattingProvider = false
	-- end

	lsp_keymaps(bufnr)

	-- Use protected call to check if cmp_nvim_lsp is available
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
end
-- -----------------------------------------------------------------------

return M

