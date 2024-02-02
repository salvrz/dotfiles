local builtin = require('telescope.builtin')
vim.keymap.set('n', '<space>p', builtin.find_files, {})
vim.keymap.set('n', '<space>g', builtin.git_files, {})
vim.keymap.set('n', '<space>s', builtin.grep_string, {})
