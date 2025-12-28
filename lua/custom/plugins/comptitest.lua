return {
  {
    'xeluxee/competitest.nvim',
    dependencies = 'MunifTanjim/nui.nvim',
    config = function()
      require('competitest').setup {
        compile_command = {
          cpp = {
            exec = 'g++',
            args = {
              '-Wall',
              '-std=c++17',
              '$(FNAME)',
              '-o',
              'main',
            },
          },
        },
        run_command = {
          cpp = {
            exec = './main',
          },
        },
        template_file = '~/dev/competitive-programming/templates/main.$(FEXT)',
        evaluate_template_modifiers = true,
        testcases_use_single_file = true,
        companion_port = 4244,
        received_problems_path = '$(CWD)/problems/$(PROBLEM).$(FEXT)',
        received_contests_directory = '$(CWD)/problems/$(CONTEST)',
      }

      vim.keymap.set('n', '<leader>crc', '<cmd>CompetiTest receive contest<CR>', { desc = '[C]omptitest [R]eceive [C]ontest' })
      vim.keymap.set('n', '<leader>crp', '<cmd>CompetiTest receive problem<CR>', { desc = '[C]omptitest [R]eceive [P]roblem' })
      vim.keymap.set('n', '<leader>crs', '<cmd>CompetiTest receive stop<CR>', { desc = '[C]omptitest [R]eceive [S]top' })
      vim.keymap.set('n', '<leader>cR', '<cmd>CompetiTest run<CR>', { desc = '[C]omptitest [R]un' })
      vim.keymap.set('n', '<leader>csu', '<cmd>CompetiTest show_ui<CR>', { desc = '[C]omptitest [S]how [U]I' })
    end,
  },
}
