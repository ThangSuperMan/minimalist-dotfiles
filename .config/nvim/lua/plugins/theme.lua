return function()
  local cmd = vim.cmd
  cmd("syntax on")
  cmd("set termguicolors")
  cmd("colorscheme everforest")
  -- cmd("colorscheme rose-pine")
  
  -- cmd("colorscheme gruvbox-material")
  -- vim.g.gruvbox_material_background = 'hard'

  -- everforest theme
  vim.g.everforest_diagnostic_line_highlight = 1
  vim.g.everforest_background = "soft"
  vim.g.everforest_disable_italic_comment = 0
  vim.g.everforest_transparent_background = 1

  cmd("set background=dark")
end
