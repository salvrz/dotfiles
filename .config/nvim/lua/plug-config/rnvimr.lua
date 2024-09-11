-- Make Ranger replace netrw and be the file explorer
vim.g.rnvimr_ex_enable = 1

-- nmap <space>r :RnvimrToggle<CR>
vim.keymap.set('n', '<space>r', ':RnvimrToggle<CR>')
