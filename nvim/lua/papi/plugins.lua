local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
augroup packer_user_config
	autocmd!
	autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})



-- --------------------------------------------------------------------------------------
-- Install your plugins here
-- --------------------------------------------------------------------------------------
return packer.startup(function(use)
	-- General
	use { "wbthomason/packer.nvim" }	-- Have packer manage itself
	use { "nvim-lua/plenary.nvim" }		-- Useful lua functions used by lots of plugins
	use { 'nvim-lua/popup.nvim' }		-- An implementation of the Popup API from vim in Neovim
	use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}	-- Markdown Preview

	-- Colorschemes
	use { "catppuccin/nvim", as = "catppuccin" }
	use { "lunarvim/darkplus.nvim", as = "darkplus"}

	-- Colorizer
	-- use { "norcalli/nvim-colorizer.lua" }
	use { 'NvChad/nvim-colorizer.lua' }

	-- Cmp
	use { "hrsh7th/nvim-cmp" }			-- The Completion plugin
	use { "hrsh7th/cmp-buffer" }		-- Buffer completions
	use { "hrsh7th/cmp-path" }			-- Path completions
	use { "hrsh7th/cmp-cmdline" }		-- Command line completions
	use { "saadparwaiz1/cmp_luasnip"}	-- Snippet completions
	use { "hrsh7th/cmp-nvim-lua"}		-- Lua completions
	use { "hrsh7th/cmp-nvim-lsp" }		-- LSP completions

	-- LSP
	use { "williamboman/mason.nvim", run = ":MasonUpdate" }	-- simple to use language server installer -- :MasonUpdate updates registry contents
	use { "williamboman/mason-lspconfig.nvim" }				-- mason requirement plugin for LSP servers
	use { "neovim/nvim-lspconfig" }		-- enables LSP 		-- mason requirement plugin for LSP servers
	use { "RRethy/vim-illuminate" } 						-- automatically highlights other uses of the word under the cursor using either LSP, Tree-sitter, or rege
	use { "jose-elias-alvarez/null-ls.nvim" } 				-- mason requirement plugin for formatter and linter servers

	-- Snippets
	use { "L3MON4D3/LuaSnip"}				--snippet engine
	use { "rafamadriz/friendly-snippets"}	-- a bunch of snippets to use

	-- Telescope
	use { "nvim-telescope/telescope.nvim" }				-- a highly extendable fuzzy finder over lists.
	use { 'nvim-telescope/telescope-media-files.nvim' }	-- Telescope extension to preview media files using Ueberzug.

	-- Treesitter
	use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
-- --------------------------------------------------------------------------------------
