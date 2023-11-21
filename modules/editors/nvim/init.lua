require("pck")
require("set")
require("remap")

vim.cmd([[let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro']])
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
