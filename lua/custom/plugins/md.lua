return {
  { -- Markdown table tidier
    'timantipov/md-table-tidy.nvim',
    opts = {
      padding = 1,
      key = '<leader>tt',
    },
  },

  { -- Markdown editing helpers
    'yousefhadder/markdown-plus.nvim',
    ft = { 'markdown' },
    config = function()
      require('markdown-plus').setup {
        filetypes = { 'markdown' },
      }
    end,
  },

  { -- Optional: nice markdown rendering in buffer
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
    config = function()
      require('render-markdown').setup {}
    end,
  },
}
