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
          vim.cmd 'Neotree toggle'
        end,
        desc,
      },
      {
        'C',
        function()
          local state = require('neo-tree.sources.manager').get_state 'filesystem'
          local node = state and state.selected_node
          if node then
            local path = node.path
            if node.type == 'file' then
              path = vim.fn.fnamemodify(path, ':h') -- Get parent directory if it's a file
            end
            vim.cmd('tcd ' .. path)
            print('Changed directory to: ' .. path)
          else
            print 'No node selected'
          end
        end,
        desc = 'Change directory to the highlighted Neo-tree node',
        noremap = true,
        silent = true,
      },
    },
    opts = {
      filesystem = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
        use_libuv_file_watcher = true,
      },
      window = {
        auto_focus = false,
      },
    },
  },
  {
    'antosha417/nvim-lsp-file-operations',
    ependencies = {
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
