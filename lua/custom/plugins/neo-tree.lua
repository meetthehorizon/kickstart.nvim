return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      {
        '<leader>e',
        function()
          local wins = vim.api.nvim_tabpage_list_wins(0)
          local neo_win = nil

          -- Identify the Neo-tree window
          for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            local ft = vim.bo[buf].filetype
            if ft == 'neo-tree' then
              neo_win = win
              break
            end
          end

          -- If Neo-tree window is found
          if neo_win then
            local cur_win = vim.api.nvim_get_current_win()

            -- If Neo-tree is open and not focused, focus on it
            if cur_win ~= neo_win then
              vim.api.nvim_set_current_win(neo_win)
            else
              -- If Neo-tree is open and focused, toggle it
              vim.cmd 'Neotree toggle'
            end
          else
            -- If Neo-tree is not open, open and focus on it
            vim.cmd 'Neotree toggle'
            vim.cmd 'Neotree focus'
          end
        end,
        desc = 'Toggle Neo-tree and focus',
      },
    },
  },
  {
    'antosha417/nvim-lsp-file-operations',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-neo-tree/neo-tree.nvim', -- makes sure that this loads after Neo-tree.
    },
    config = function()
      require('lsp-file-operations').setup()
    end,
  },
  {
    's1n7ax/nvim-window-picker',
    version = '2.*',
    config = function()
      require('window-picker').setup {
        filter_rules = {
          include_current_win = false,
          autoselect_one = true,
          bo = {
            filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
            buftype = { 'terminal', 'quickfix' },
          },
        },
      }
    end,
  },
}
