return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  cmd = 'NeoTree', -- lazy-load only when NeoTree is called
  keys = { { '<leader>e', ':NeoTree toggle<CR>', desc = 'Toggle Explorer' } },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['<cr>'] = 'open',
          ['t'] = 'open_tabnew',
          ['v'] = 'open_vsplit',
          ['s'] = 'open_split',
        },
      },
      follow_current_file = {
        enabled = true,
      },
    },
  },
  config = function(_, opts)
    require('neo-tree').setup(opts)

    local function ensure_neotree_left()
      for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].filetype == 'neo-tree' then
          return
        end
      end
      vim.cmd 'NeoTree reveal left'
    end

    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        local argv = vim.fn.argv()
        if #argv > 0 and vim.fn.isdirectory(argv[1]) == 1 then
          vim.schedule(ensure_neotree_left)
        end
      end,
    })

    vim.api.nvim_create_autocmd('TabEnter', {
      callback = function()
        vim.schedule(ensure_neotree_left)
      end,
    })
  end,
}
