vim.keymap.set("n", "<leader>gs", vim.cmd.Git);

require('telescope').setup{
  defaults = {
    shorten_path = true,
    mappings = {
      i = {
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
  },
  extensions = {
  }
}
