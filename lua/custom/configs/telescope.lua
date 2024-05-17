local telescope_utils = require 'telescope.actions.utils'
local utils = require 'telescope.actions.utils'
local actions = require 'telescope.actions'

local _print = function(item)
  -- vim.api.nvim_echo({ { vim.inspect(item) } }, true, {})
end

local mark_file = function(tb)
  print 'add to harpoon'
  actions.drop_all(tb)
  actions.add_selection(tb)
  telescope_utils.map_selections(tb, function(selection)
    local file = selection[1]
    local context = {
      col = 0,
      row = 1,
    }

    -- This lets it work with live grep picker
    if selection.filename then
      -- _print(selection)
      context.row = selection.lnum or 1
      context.col = selection.col or 0
      file = selection.filename
    end

    -- this lets it work with git status picker
    if selection.value then
      _print(selection)
      file = selection.filename
    end
    -- print(file)
    -- pcall(require("harpoon.mark").add_file, file)
    -- pcall(require("harpoon"):list():append, file)
    pcall(function()
      local item = {
        value = file,
        context = context,
      }
      -- print(vim.inspect(item))
      -- vim.api.nvim_echo({ { vim.inspect(item) } }, true, {})
      require('harpoon'):list():add(item)
    end)
  end)
  actions.remove_selection(tb)
end

return {
  defaults = {
    mappings = {
      n = {
        ['<C-h>'] = mark_file,
      },
      i = {
        ['<C-h>'] = mark_file,
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown(),
    },
  },
}
