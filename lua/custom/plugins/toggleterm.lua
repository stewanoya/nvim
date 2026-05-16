return {
  'akinsho/toggleterm.nvim',
  version = '*',
  keys = {
    { '<C-\\>', desc = 'Toggle terminal' },
    { '<leader>tg', desc = '[T]oggle Lazy[g]it' },
  },
  opts = {
    open_mapping = [[<C-\>]],
    direction = 'float',
    float_opts = {
      border = 'curved',
    },
    shell = 'pwsh',
  },
  config = function(_, opts)
    require('toggleterm').setup(opts)

    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new {
      cmd = 'lazygit',
      hidden = true,
      direction = 'float',
      float_opts = { border = 'curved' },
      on_open = function(term)
        vim.cmd 'startinsert!'
        vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
      end,
    }

    vim.keymap.set('n', '<leader>tg', function() lazygit:toggle() end, { desc = '[T]oggle Lazy[g]it' })
  end,
}
