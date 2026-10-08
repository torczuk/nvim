-- Harpoon 2: quick per-project file bookmarks, with a Telescope picker
-- https://github.com/ThePrimeagen/harpoon/tree/harpoon2
return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()

      -- Telescope picker over the harpoon list; <C-d> removes the selected entry
      local function toggle_telescope()
        local conf = require('telescope.config').values
        local finders = require 'telescope.finders'
        local pickers = require 'telescope.pickers'
        local actions = require 'telescope.actions'
        local action_state = require 'telescope.actions.state'

        local function make_finder()
          local paths = {}
          for _, item in ipairs(harpoon:list().items) do
            table.insert(paths, item.value)
          end
          return finders.new_table { results = paths }
        end

        pickers
          .new({}, {
            prompt_title = 'Harpoon',
            finder = make_finder(),
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
            attach_mappings = function(prompt_bufnr, map)
              local remove = function()
                local entry = action_state.get_selected_entry()
                if not entry then
                  return
                end
                local list = harpoon:list()
                list:remove(list:get_by_value(entry[1]))
                action_state.get_current_picker(prompt_bufnr):refresh(make_finder(), { reset_prompt = false })
              end
              map({ 'i', 'n' }, '<C-d>', remove)
              return true
            end,
          })
          :find()
      end

      local map = vim.keymap.set
      map('n', '<leader>a', function() harpoon:list():add() end, { desc = 'Harpoon [A]dd file' })
      map('n', '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon menu' })
      map('n', '<leader>sm', toggle_telescope, { desc = '[S]earch harpoon [M]arks' })
      for i = 1, 4 do
        map('n', '<leader>' .. i, function() harpoon:list():select(i) end, { desc = 'Harpoon file ' .. i })
      end
      map('n', '<C-S-P>', function() harpoon:list():prev() end, { desc = 'Harpoon previous file' })
      map('n', '<C-S-N>', function() harpoon:list():next() end, { desc = 'Harpoon next file' })
    end,
  },
}
