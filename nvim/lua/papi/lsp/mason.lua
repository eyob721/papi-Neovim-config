-- ----------------------------------------------------------------------
-- Add installed servers here
-- ----------------------------------------------------------------------
local servers = {
	"clangd",	-- c and c++
	"pyright",	-- python
	"marksman",
	"html", 	-- html
	"cssls",	-- css, scss, less
	"bashls",	-- bash
	"jsonls",	-- json
	"lua_ls",
	-- "tsserver",
	-- "yamlls",
}
-- ----------------------------------------------------------------------


-- Use protected call to check if mason is available
local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

-- Setup mason
local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}
mason.setup(settings)

-- Use protected call to check if mason-lspconfig is available
local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
	return
end

-- Setup mason lspconfig
mason_lspconfig.setup({
	ensure_installed = servers,
	automatic_installation = true,
})

-- Use protected call to check if lspconfig is available
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end


local opts = {}

-- Enable the language servers using a loop
-- How it works is:
-- 1	- First add data to an option called capabilities in lspconfig's defaults.
-- 		- This new data comes from cmp-nvim-lsp.
-- 		- It tells the language server what features nvim-cmp adds to the editor.
-- 
-- 2	- Then call an autocommand on the event LspAttach.
-- 		- This autocommand will be triggered every time a language server is attached to a buffer.
-- 		- This is where all keybindings and commands are created.
-- 
-- 3	- Finally to enable the language server, call the .setup() function for each server
-- 
for _, server in pairs(servers) do
	opts = {
		on_attach = require("papi.lsp.handlers").on_attach,
		capabilities = require("papi.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "papi.lsp.settings." .. server)
	if require_ok then
	opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)	-- enables the language server
	-- e.g. require 'lspconfig'.clangd.setup{}

end

