local builtin = require('telescope.builtin')

--vim.keymap.set('n', '<leader>fa', builtin.find_files, {})

vim.keymap.set('n', '<leader>fa', function()
  builtin.find_files({
    shorten_path = true, 
    cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:gs?\\?/?'),
    path_display = { 'truncate' }
  })
end)

vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function() 
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

