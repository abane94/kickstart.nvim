local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- local function openAndFocus(opts)
  --   api.tree.toggle(opts)
  --   api.tree.find_file({ open = true, focus = true })
  -- end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  -- vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
  -- vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
  vim.keymap.set('n', '<leader>t', api.tree.toggle, opts('Toggle'))
  -- vim.keymap.set('n', '<leader>t', openAndFocus, opts('Toggle'))
end

return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {
      on_attach = my_on_attach,
    }
  end,
}


-- file tree keymaps

-- vim.keymap.set('n', '<leader>t', require('nvim-tree.api').tree.toggle, {
--   desc = "show fs tree",
--   buffer = bufnr,
--   norenap = true,
--   silent = true,
--   nowait = true
-- })

