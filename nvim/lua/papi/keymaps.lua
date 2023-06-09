local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   terminal_mode = "t",
--   command_mode = "c",

-- Normal ------------------------------------------------
keymap("n", "<leader>e", ":Lex 30<CR>", opts)		-- Open file explorer
keymap("n", "<leader>w", ":set list!<CR>", opts)	-- Toggle whitespaces

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize windows with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)


-- Insert ------------------------------------------------ 
-- Press jk fast to exit insert mode 
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)


-- Visual ------------------------------------------------ 
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Pasting remap
keymap("v", "p", '"_dP', opts)

-- Visual Block ------------------------------------------------ 

-- Terminal  ------------------------------------------------
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Telescope
-- keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files(require ('telescope.themes').get_dropdown({ previewer = false }))<CR>", opts)
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<C-t>", "<cmd>Telescope live_grep<CR>", opts)

-- ------------------------------------------------------------------------
-- Moving text up and down [hjkl] -----------------------------------------
-- ------------------------------------------------------------------------
-- (Normal mode)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==", opts) -- keymap("n", "<A-Up>", "<Esc>:m-2<CR>", opts)
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==", opts) -- keymap("n", "<A-Down>", "<Esc>:m+<CR>", opts)

-- (Insert mode)
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)

-- (Visual mode)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m .+1<CR>==", opts)

-- (Visual Block Mode)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts) -- keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts) -- keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- ------------------------------------------------------------------------


-- ------------------------------------------------------------------------
-- Moving text up and down [Arrow Keys] -----------------------------------
-- ------------------------------------------------------------------------
-- (Normal mode)
keymap("n", "<A-Up>", "<Esc>:m .-2<CR>==", opts) -- keymap("n", "<A-Up>", "<Esc>:m-2<CR>", opts)
keymap("n", "<A-Down>", "<Esc>:m .+1<CR>==", opts) -- keymap("n", "<A-Down>", "<Esc>:m+<CR>", opts)

-- (Insert mode)
keymap("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", opts)
keymap("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", opts)

-- (Visual mode)
keymap("v", "<A-Up>", ":m .-2<CR>==", opts)
keymap("v", "<A-Down>", ":m .+1<CR>==", opts)

-- (Visual Block Mode)
keymap("x", "<A-Up>", ":move '<-2<CR>gv-gv", opts) -- keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-Down>", ":move '>+1<CR>gv-gv", opts) -- keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- ------------------------------------------------------------------------





