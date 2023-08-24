--
-- Configure lsp-zero
--
local lsp = require('lsp-zero').preset({})

lsp.ensure_installed({
	'lua_ls',
	'rust_analyzer',
})

lsp.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the avaiable actions
	lsp.default_keymaps({
		buffer = bufnr,
		preserve_mappings = false  -- override default lsp keymappings
	})
end)

-- lua lsp for nvim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

-- use rust-tools to setup rust-analyzer
lsp.skip_server_setup( {'rust_analyzer'} )

lsp.setup()

--
-- nvim-cmp settings
--
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local cmp = require('cmp')
cmp.setup({
	formatting = {
		format = function(entry, vim_item)
			-- shorten the item description
			vim_item.abbr = string.sub(vim_item.abbr, 1, 20)
			-- make rust items consistent
			vim_item.menu = nil
			return vim_item
		end
	},
	mapping = {
		-- Scroll through documentation
		['<M-u>'] = cmp.mapping.scroll_docs(-4),
		['<M-i>'] = cmp.mapping.scroll_docs(4),

		-- `Enter` to confirm completion
		['<CR>'] = cmp.mapping.confirm( {select = false} ),

		-- Tab to go down autocomplete options
		['<Tab>'] = function(fallback)
			if not cmp.select_next_item() then
				if vim.bo.buftype ~= 'prompt' and has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end
		end,

		-- Shift+Tab to go up autocomplete options
		['<S-Tab>'] = function(fallback)
			if not cmp.select_prev_item() then
				if vim.bo.buftype ~= 'prompt' and has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end
		end,
	}
})


--
-- lspconfig setings
--

-- rust-tools (rust-analyzer)
local rust_tools = require('rust-tools')
rust_tools.setup({
	server = {
		on_attach = function(_, bufnr)
			vim.keymap.set('n', '<space>l', rust_tools.hover_actions.hover_actions, {buffer = bufnr})
		end
	}
})


-- ccls
require'lspconfig'.ccls.setup {
	init_options = {
		compilationDatabaseDirectory = "build";
		index = {
			thread = 0;
		};
		clang = {
			excludeArgs = { "-frounding-math" };
		};
	}
}
