vim.keymap.set('n', '<leader>r', function()
  vim.cmd 'w'
  vim.cmd("TermExec cmd='python3 " .. vim.fn.expand '%' .. "'")
end, { desc = 'Run current python file' })
