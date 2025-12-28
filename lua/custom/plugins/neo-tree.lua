return {
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
    config = function()
      require('nvim-web-devicons').setup {
        default = true,
        strict = true,
      }
    end,
  },

  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    cmd = 'Neotree',
    keys = {
      { '<leader>e', '<cmd>Neotree toggle<CR>' },
      { '<leader>o', '<cmd>Neotree focus<CR>' },
    },
    config = function()
      require('neo-tree').setup {
        close_if_last_window = true,
        popup_border_style = 'rounded',

        default_component_configs = {
          icon = {
            folder_closed = '󰉋',
            folder_open = '󰝰',
            folder_empty = '󰉖',
            default = '󰈚',
          },
          modified = { symbol = '' },
        },

        window = {
          position = 'left',
          width = 32,
          mappings = {
            ['l'] = 'open',
            ['h'] = 'close_node',
            ['<cr>'] = 'open',
            ['q'] = 'close_window',

            -- 🔥 TAB-LOCAL CD
            ['c'] = {
              function(state)
                local node = state.tree:get_node()
                local path = node:get_id()

                if node.type ~= 'directory' then
                  path = vim.fn.fnamemodify(path, ':h')
                end

                vim.cmd('tcd ' .. vim.fn.fnameescape(path))
                vim.notify('tcd → ' .. path, vim.log.levels.INFO)
              end,
              desc = 'tcd into directory',
            },

            -- C → tcd into parent directory
            ['C'] = {
              function(state)
                local node = state.tree:get_node()
                local path = node:get_id()

                if node.type ~= 'directory' then
                  path = vim.fn.fnamemodify(path, ':h')
                end

                local parent = vim.fn.fnamemodify(path, ':h')
                vim.cmd('tcd ' .. vim.fn.fnameescape(parent))
                vim.notify('tcd → ' .. parent, vim.log.levels.INFO)
              end,
              desc = 'tcd into parent directory',
            },
          },
        },

        filesystem = {
          follow_current_file = { enabled = true },
          group_empty_dirs = true,
          hijack_netrw_behavior = 'open_default',
        },
      }
    end,
  },
}
