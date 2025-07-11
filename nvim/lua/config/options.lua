local o = vim.o
local wo = vim.wo
local opt = vim.opt
o.encoding = "UTF-8"
o.lazyredraw = true
wo.number = true
wo.relativenumber = true
wo.cursorline = true
wo.cursorcolumn = true
o.compatible = false
o.ruler = true
o.smarttab = true
o.cindent = true
o.hidden = true
o.confirm = true
o.showmatch = true
o.autoindent = true
o.linebreak = true
wo.foldcolumn = "1"
o.path = vim.o.path .. "**"
o.switchbuf = "useopen"
o.clipboard = "unnamedplus"
o.regexpengine = 1
o.scrolloff = 9
o.synmaxcol = 170
wo.colorcolumn = "85"
o.pumblend = 25
o.winblend = 25
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
vim.bo.softtabstop = 2
o.expandtab = true
o.inccommand = "split"
o.list = true
o.listchars = "tab:→ ,eol:↲,nbsp:␣,trail:·,space:·,extends:⟩,precedes:⟨"
o.shortmess = vim.o.shortmess .. "c"
wo.signcolumn = "yes"
o.updatetime = 500
o.wildmenu = true
o.wildignore = "*/node_modules/*,*/dist/*"
o.background = "dark"
if not o.guifont then
  o.guifont = "Fira Code:h12"
end
if vim.fn.has("termguicolors") then
  o.termguicolors = true
end
o.mouse = "a"

vim.opt.spell = true
vim.opt.spelllang = { "en_us" }
