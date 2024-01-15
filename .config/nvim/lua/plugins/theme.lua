return function()
  local cmd = vim.cmd
  cmd("syntax on")
  cmd("set termguicolors")
  -- cmd("colorscheme everforest")
  -- cmd("colorscheme edge")
  -- cmd("colorscheme limestone")
  -- cmd("colorscheme space-nvim")
  cmd("colorscheme grey")
  
  -- cmd("colorscheme catppuccin")
  -- cmd("set background=light")
  -- cmd("colorscheme industry")
  cmd("set background=light")

  -- everforest theme
  -- vim.g.everforest_diagnostic_line_highlight = 1
  -- vim.g.everforest_background = "soft"
  -- vim.g.everforest_disable_italic_comment = 0
  -- vim.g.everforest_transparent_background = 1

  -- cmd("set background=dark")

  -- vim.cmd([[highlight NotifyBackground guibg=#000000]])
  -- vim.cmd [[ highlight VirtualTextError guifg=#e67e80 ]]
  -- vim.cmd [[ highlight VirtualTextInfo guifg=#7fbbb3 ]]
  -- vim.cmd [[ highlight VirtualTextWarning guifg=#7fbbb3 ]]
  -- vim.cmd [[ highlight VirtualTextHint guifg=#7fbbb3 ]]

  -- vim.fn.sign_define({
  --   {
  --     name = 'DiagnosticSignError',
  --     text = '',
  --     texthl = 'DiagnosticSignError',
  --     linehl = 'ErrorLine',
  --   },
  --   {
  --     name = 'DiagnosticSignWarn',
  --     text = '',
  --     texthl = 'DiagnosticSignWarn',
  --     linehl = 'WarningLine',
  --   },
  --   {
  --     name = 'DiagnosticSignInfo',
  --     text = '',
  --     texthl = 'DiagnosticSignInfo',
  --     linehl = 'InfoLine',
  --   },
  --   {
  --     name = 'DiagnosticSignHint',
  --     text = '',
  --     texthl = 'DiagnosticSignHint',
  --     linehl = 'HintLine',
  --   },
  -- })
end
