-- Lazy.nvim plugin specification
return {
  {
    'rcarriga/nvim-notify',
    config = function()
      local notify = require 'notify'

      -- Set nvim-notify as the default notification handler
      vim.notify = notify

      -- Redirect LSP messages to nvim-notify
      vim.lsp.handlers['window/showMessage'] = function(_, result, ctx)
        -- 'result' contains the message and type
        local client = vim.lsp.get_client_by_id(ctx.client_id)

        local level_map = {
          [vim.lsp.protocol.MessageType.Error] = vim.log.levels.ERROR,
          [vim.lsp.protocol.MessageType.Warning] = vim.log.levels.WARN,
          [vim.lsp.protocol.MessageType.Info] = vim.log.levels.INFO,
          [vim.lsp.protocol.MessageType.Log] = vim.log.levels.DEBUG,
        }

        notify(result.message, level_map[result.type] or vim.log.levels.INFO, {
          title = client and client.name or 'LSP',
        })
      end
    end,
  },
}
