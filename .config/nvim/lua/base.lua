vim.cmd("autocmd!")
vim.cmd('set noswapfile')
vim.cmd [[ augroup highlight_yank]]
vim.cmd [[ autocmd!]]
vim.cmd [[ autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({higroup = "Substitute", timeout = 250})]]
vim.cmd [[ augroup END]]

vim.cmd("let g:git_messenger_floating_win_opts = { 'border': 'single'}")
vim.cmd("let g:git_messenger_popup_content_margins = v:false")

vim.g['closetag_filenames'] = '*.erb'

vim.g.markdown_fenced_languages = {'html', 'ruby'}

vim.o.termguicolors = true
-- Faster completion
vim.cmd('set updatetime=300')
vim.cmd('set timeoutlen=500')
vim.cmd('set mouse=a')
vim.cmd('set noshowmode')
vim.cmd('set hidden') -- Required to keep multiple buffers open multiple buffers
-- vim.cmd('set lazyredraw') -- Improve scrolling performance when navigating through large results
vim.cmd('set ttyfast') -- U got a fast terminal
vim.cmd('set regexpengine=1')
vim.cmd('set synmaxcol=4096')
vim.cmd('set fo-=c fo-=r fo-=o')
-- add asterisks in block comments
-- vim.opt.formatoptions:append { 'r' }

-- vim.cmd('set shortmess+=c')

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.wo.number = true

-- vim.opt.title = true
vim.opt.autoindent = true
vim.opt.undofile = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
-- vim.opt.relativenumber = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 5
vim.opt.shell = 'fish'
vim.opt.backupskip = { '/tmp/*', '/private/tmp/*' }
vim.opt.inccommand = 'split'
vim.opt.ignorecase = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false -- No Wrap lines
vim.opt.backspace = { 'start', 'eol', 'indent' }

-- vim.opt.path:append { '**' } -- Finding files - Search down into subfolders
-- vim.opt.wildignore:append { '*/node_modules/*' }

-- vim.cmd('set list')
-- Disable tabline when we have more than one
-- vim.cmd('set showtabline=0')
-- vim.cmd('set list listchars=tab:»·,trail:·')

-- Enable automatic trailing whitespace removal
-- vim.cmd([[au BufWritePre *.rb :%s/\s\+$//e]])

vim.cmd([[ au FileType * set fo-=c fo-=r fo-=o ]])
-- Go file config
-- vim.cmd([[au FileType go set noexpandtab]])
-- vim.cmd([[au FileType go set shiftwidth=4]])
-- vim.cmd([[au FileType go set softtabstop=4]])
-- vim.cmd([[au FileType go set tabstop=4]])
