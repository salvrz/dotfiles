--
-- General
--
vim.cmd([[syntax enable]])		-- Enable syntax highlighting	
vim.opt.hidden		= true		-- Required to keep multiple buffers open
vim.opt.mouse		= "a"		-- Enable mouse
vim.opt.number		= true		-- Line Numbers
vim.opt.colorcolumn	= "80"		-- Column marker
vim.opt.ruler		= true		-- Show the cursor position all the time
vim.opt.iskeyword:append { '-' }	-- Treat dash separated words as a word text object
vim.opt.fileencoding	= "utf-8"	-- Encoding written to a file
vim.opt.splitbelow	= true		-- Horizontal splits will automatically be below
vim.opt.splitright	= true		-- Vertical splits will automatically be to the right
vim.o.noshowmode	= true		-- Don't display mode (eg INSERT)
vim.opt.clipboard	= "unnamedplus"	-- Copy paste between vim and everything else
-- vim.opt.nobackup	= true		-- Recommended by coc
-- vim.opt.nowritebackup	= true		-- Recommended by coc
vim.opt.updatetime	= 300		-- Faster completion
vim.opt.timeoutlen	= 500		-- Default timeoutlen is 1000 ms

--
-- Indentation
--
vim.o.tabstop		= 8		-- Tab spacing
vim.o.softtabstop	= 8		--
vim.o.shiftwidth	= 8		-- Number of space characters inserted for indentation
vim.o.noexpandtab	= true		-- Use tabs over spaces for indentation
vim.opt.smarttab	= true		-- Makes indenting smart
vim.opt.autoindent	= true		-- Good auto indent
vim.opt.showtabline	= 2		-- Always show tabs
vim.opt.cmdheight	= 2		-- More space for displaying messages

--
-- Text wrapping
--
vim.opt.textwidth	= 0		-- No max text width
vim.opt.wrapmargin	= 0		-- No max wrap margin
vim.opt.wrap		= true		-- Long lines wrap
vim.opt.linebreak	= true		-- Wrap on full words (no newline added)
