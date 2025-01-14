local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- if not vim.loop.fs_stat(lazypath) then
--  vim.fn.system({
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

  {
    'neoclide/coc.nvim',
    branch = 'master',
    build = "yarn install --frozen-lockfile",
  },
  { 'nvim-treesitter/nvim-treesitter', cmd = 'TSUpdate'},
  { 'mg979/vim-visual-multi', branch = 'master'},
  { 'Exafunction/codeium.vim', branch = 'main' },
  'f-person/git-blame.nvim',
  {
    'Wansmer/treesj',
    keys = { '=t', '=j', '=s' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup({})
    end,
    lazy = true,
  },
  'vifm/vifm.vim',
  'ntpeters/vim-better-whitespace',
  'tpope/vim-fugitive',
  'airblade/vim-gitgutter',

  {
    'lilydjwg/colorizer',
    ft = 'css,scss,html,less',
  },

  'vim-airline/vim-airline',
  'vim-airline/vim-airline-themes',

  'junegunn/vim-easy-align',

  'tpope/vim-commentary',
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'tpope/vim-surround',
  },
  {
    'AndrewRadev/tagalong.vim',
    ft = 'html,jsx,tsx,javascriptreact,typescriptreact',
  },
  {
    'alvan/vim-closetag',
    ft = 'html,jsx,tsx,javascriptreact,typescriptreact',
  },
  'MunifTanjim/nui.nvim',
  "dominikduda/vim_current_word",
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>gz", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    },
  },
})

local set = vim.keymap.set

set('n', '=t', require('treesj').toggle)
set('n', '=T', function()
    require('treesj').toggle({ split = { recursive = true } })
end)
set('n', '=j', require('treesj').join)
set('n', '=J', function()
    require('treesj').join({ split = { recursive = true } })
end)
set('n', '=s', require('treesj').split)
set('n', '=J', function()
    require('treesj').split({ split = { recursive = true } })
end)
