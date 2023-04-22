local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not vim.loop.fs_stat(lazypath) then
--   vim.fn.system({
--     "git",
--     "clone",
--     "--filter=blob:none",
--     "https://github.com/folke/lazy.nvim.git",
--     "--branch=stable", -- latest stable release
--     lazypath,
--   })
-- end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  { 'jacoborus/tender.vim', lazy = false },
  { 'editorconfig/editorconfig-vim', lazy = false },

  'christoomey/vim-tmux-navigator',

  { 'neoclide/coc.nvim', branch = 'master', build = "npx yarn install --frozen-lockfile" },
  { 'nvim-treesitter/nvim-treesitter', cmd = 'TSUpdate'},
  { 'mg979/vim-visual-multi', branch = 'master'},

  'vifm/vifm.vim',
  'ntpeters/vim-better-whitespace',
  'tpope/vim-fugitive',
  'airblade/vim-gitgutter',

  'lilydjwg/colorizer',

  'vim-airline/vim-airline',
  'vim-airline/vim-airline-themes',

  'junegunn/vim-easy-align',

  'tpope/vim-commentary',
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',
  'tpope/vim-surround',
  'AndrewRadev/tagalong.vim',
  'alvan/vim-closetag',
})
