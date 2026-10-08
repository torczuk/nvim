-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'nvimtools/none-ls.nvim',
    dependencies = {
      'nvimtools/none-ls-extras.nvim',
      'jayp0521/mason-null-ls.nvim',
    },
    config = function()
      -- setup mason-null-ls to auto-install formatters/linters
      require('mason-null-ls').setup {
        ensure_installed = {
          'ruff',
          'prettier',
          'shfmt',
        },
        automatic_installation = true,
      }
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup()
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-treesitter-textobjects').setup { move = { set_jumps = true } }
      local move = require 'nvim-treesitter-textobjects.move'
      local map = function(lhs, fn, q, desc)
        vim.keymap.set({ 'n', 'x', 'o' }, lhs, function() fn(q, 'textobjects') end, { desc = desc })
      end
      map(']m', move.goto_next_start, '@function.outer', 'Next function start')
      map('[m', move.goto_previous_start, '@function.outer', 'Prev function start')
      map(']M', move.goto_next_end, '@function.outer', 'Next function end')
      map('[M', move.goto_previous_end, '@function.outer', 'Prev function end')
    end,
  },
}
