-- Use a protective call to call lspconfig
-- this is a quick check if lsp is available
-- if it is not available, then it will return nothing and stop executing
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require ("papi.lsp.mason")
require ("papi.lsp.handlers").setup()
-- require "papi.lsp.null-ls"

