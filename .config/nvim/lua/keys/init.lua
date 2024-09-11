--
-- Escape alternatives (j/k + k/j)
--
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('i', 'kj', '<Esc>')

--
-- Window splitting (alt + cv)
--
vim.keymap.set('n', '<M-v>', '<C-w>v')
vim.keymap.set('n', '<M-c>', '<C-w>s')

--
-- Window nav (ctrl + hjkl)
--
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

--
-- Window resize (alt + hjkl)
--
vim.keymap.set('n', '<M-j>', ':resize -2<CR>')
vim.keymap.set('n', '<M-k>', ':resize +2<CR>')
vim.keymap.set('n', '<M-h>', ':vertical resize -2<CR>')
vim.keymap.set('n', '<M-l>', ':vertical resize +2<CR>')

--
-- Switch text buffers (tab & shift + tab)
--
vim.keymap.set('n', '<TAB>', ':bnext<CR>')
vim.keymap.set('n', '<S-TAB>', ':bprevious<CR>')

--
-- Better tabbing
--
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

--
-- Spell check (alt + s)
--
vim.keymap.set('n', '<M-s>', ':setlocal spell!<CR>')
