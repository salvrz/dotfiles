-- TODO: auto install vim-plug(?)


-- Plug identifier
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/autoload/plugged')

	-- LSP & Autocompletion
		-- LSP
		Plug('neovim/nvim-lspconfig')
		Plug('williamboman/mason.nvim')
		Plug('williamboman/mason-lspconfig.nvim')

		-- Autocomplete
		Plug('hrsh7th/nvim-cmp')
		Plug('hrsh7th/cmp-nvim-lsp')
		Plug('L3MON4D3/LuaSnip')

		-- Connect LSP & Autocomplete
		Plug('VonHeikemen/lsp-zero.nvim', { branch = 'v2.x' } )

	-- Rust lsp setup
	Plug('simrat39/rust-tools.nvim')

	-- Extra nvim lua functions (telescope prereq)
	Plug('nvim-lua/plenary.nvim')

	-- Fuzzy finder
	Plug('nvim-telescope/telescope.nvim', { tag = '0.1.2' })

	-- Auto pairs for ( [ {
	Plug('jiangmiao/auto-pairs')

	-- Ranger
	Plug('kevinhwang91/rnvimr', { ['do'] = 'make sync' })

	-- Git
	Plug('tpope/vim-fugitive')

	-- Man
	Plug('vim-utils/vim-man')

	-- Themes
	Plug('nikolvs/vim-sunbather')

	-- Lua fork of web devicons
	Plug('nvim-tree/nvim-web-devicons')

	-- Start screen
	Plug('goolord/alpha-nvim')

	-- Ascii art for start screen
	Plug('MaximilianLloyd/ascii.nvim')

vim.call('plug#end')
