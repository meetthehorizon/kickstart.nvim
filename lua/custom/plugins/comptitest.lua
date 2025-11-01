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
        received_contests_prompt_directory = false,
        start_receiving_persistently_on_setup = true,
      }
    end,
  },
}
