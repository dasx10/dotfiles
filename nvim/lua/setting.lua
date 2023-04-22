vim.o.encoding = 'UTF-8'
vim.o.lazyredraw = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.cursorline = true
vim.wo.cursorcolumn = true
vim.o.compatible = false
vim.o.ruler = true
vim.o.smarttab = true
vim.o.cindent = true
vim.o.expandtab = true
vim.o.hidden = true
vim.o.confirm = true
vim.o.showmatch = true
vim.o.autoindent = true
vim.o.linebreak = true


-- vim.opt.statusline = '[%n]\\ %(%F%{(&mod?"*":"")}%)\ \%\\☰\\ %{FugitiveHead()}%\ \%\\☰\\ %{@.}%\ %=%{&fenc}\ %l/%L\ %y'
vim.wo.foldcolumn = "1"
vim.o.path = vim.o.path .. '**'
vim.o.switchbuf = 'useopen'
vim.o.regexpengine = 1
vim.o.scrolloff = 9
vim.o.synmaxcol = 170
vim.wo.colorcolumn = '85'
vim.o.pumblend = 25
vim.o.winblend = 25
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.tabstop = 2
vim.o.clipboard = 'unnamedplus'
vim.o.inccommand = 'split'
vim.o.list = true
vim.o.listchars = 'tab:→ ,eol:↲,nbsp:␣,trail:·,space:·,extends:⟩,precedes:⟨'
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.wo.signcolumn = 'yes'
vim.o.updatetime = 500
vim.o.wildmenu = true
vim.o.wildignore = '*/node_modules/*,*/dist/*'
vim.o.background = 'dark'

if not vim.o.guifont then
  vim.o.guifont = 'Fira Code:h12'
end

if vim.fn.has('termguicolors') then
  vim.o.termguicolors = true
end

-- vim.cmd('filetype off')
-- vim.cmd('filetype plugin indent on')
-- vim.cmd('syntax on')
-- vim.cmd('highlight Cursorline cterm=bold ctermbg=black')
vim.o.mouse = 'a'
