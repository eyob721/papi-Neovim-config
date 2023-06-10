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
	use { "lunarvim/darkplus.nvim", as = "darkplus"}
	use { "ribru17/bamboo.nvim", as = "bamboo" }

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
	-- use { "eyob721/nvim-ts-rainbow" }

	-- Autopairs
	use { "windwp/nvim-autopairs" }						-- Autopairs, integrates with both cmp and treesitter
	use { 'echasnovski/mini.nvim', branch = 'stable' }	-- Add, delete, replace, find, highlight surrounding (like pair of parenthesis, quotes, etc.)

	-- Comments
	use { "numToStr/Comment.nvim" }							-- Smart and powerful comment plugin for neovim. Supports treesitter, dot repeat, left-right/up-down motions, hooks, and more
	use { "JoosepAlviste/nvim-ts-context-commentstring" }	-- A Neovim plugin for setting the commentstring option based on the cursor location in the file. The location is checked via treesitter queries.

	-- Git
	use { "lewis6991/gitsigns.nvim" }			-- Git integration for buffers

	-- File Explorer (Nvim-tree)
	use { "nvim-tree/nvim-tree.lua" }			-- A file explorer tree for neovim written in lua
	use { "nvim-tree/nvim-web-devicons" }		-- Used to display file icons

	-- Bufferline
	use { "akinsho/bufferline.nvim" }		-- A snazzy bufferline for Neovim
	use { "moll/vim-bbye" }					-- Bbye allows you to do delete buffers (close files) without closing your windows or messing up your layout.

	-- Lualine
	use { 'nvim-lualine/lualine.nvim' }		-- A blazing fast and easy to configure Neovim statusline written in Lua.

	-- Indent balnkline
	use ( "lukas-reineke/indent-blankline.nvim" )	-- Indent guides for Neovim

	-- Toggle Terminal
	use {"akinsho/toggleterm.nvim" }		-- A neovim lua plugin to help easily manage multiple terminal windows


	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
-- --------------------------------------------------------------------------------------
