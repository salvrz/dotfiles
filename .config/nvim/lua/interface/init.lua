--
-- Interface tweaks
--
-- hi Normal ctermbg=NONE guibg='#131a1c' gui=NONE
-- hi LineNr ctermbg=NONE guibg='#131a1c'
--vim.api.nvim_set_hl(0, 'Normal', { ctermbg = nil, bg = "#131a1c" })
--vim.api.nvim_set_hl(0, 'LineNr', { ctermbg = nil, bg = "#131a1c" })
vim.cmd[[hi Normal ctermbg=NONE guibg='#131a1c']]
vim.cmd[[hi LineNr ctermbg=NONE guibg='#131a1c']]

vim.opt.signcolumn	= 'no'

--
-- Cursor config
--
vim.opt.guicursor:append { 'n:hor20-Cursor/lCursor' }
vim.opt.guicursor:append { 'i:ver25-iCursor' }
