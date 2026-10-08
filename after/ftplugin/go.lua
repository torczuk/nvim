-- Override the built-in go ftplugin's [[ / ]] (which have no description)
-- with treesitter-textobjects moves, so they show up nicely in <leader>sk.
local ok, move = pcall(require, 'nvim-treesitter-textobjects.move')
if not ok then
  return
end

local map = function(lhs, fn, desc)
  vim.keymap.set({ 'n', 'x', 'o' }, lhs, function() fn('@function.outer', 'textobjects') end, { buffer = true, desc = desc })
end

map(']]', move.goto_next_start, 'Next function')
map('[[', move.goto_previous_start, 'Prev function')
