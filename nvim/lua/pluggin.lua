local js_based_languages = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
  "vue",
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
 if not vim.loop.fs_stat(lazypath) then
   vim.fn.system({
     "git",
     "clone",
     "--filter=blob:none",
     "https://github.com/folke/lazy.nvim.git",
     "--branch=stable", -- latest stable release
     lazypath,
   })
 end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  { 'jacoborus/tender.vim', lazy = false },
  { 'editorconfig/editorconfig-vim', lazy = false },

  'christoomey/vim-tmux-navigator',

  { 'neoclide/coc.nvim', branch = 'master', build = "npx yarn install --frozen-lockfile" },
  { 'nvim-treesitter/nvim-treesitter', cmd = 'TSUpdate'},
  { 'mg979/vim-visual-multi', branch = 'master'},
  { 'Exafunction/codeium.vim', branch = 'main' },
  'f-person/git-blame.nvim',
  {
    'Wansmer/treesj',
    keys = { '=t', '=j', '=s' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup({
      })
    end,
  },
  {
    'barrett-ruth/import-cost.nvim',
    build = 'sh install.sh yarn',
    config = true
  },
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
  "jackMort/ChatGPT.nvim", event = "VeryLazy", config = function() require("chatgpt").setup() end, dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim"
  },
  'MunifTanjim/nui.nvim',
 	-- Debug
	'mfussenegger/nvim-dap',
	{
		'mxsdev/nvim-dap-vscode-js',
		dependencies = {"mfussenegger/nvim-dap"},
	},
	{
		'microsoft/vscode-js-debug',
		lazy = false,
  		build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
	}, "dominikduda/vim_current_word",
  { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap"} },
 	-- Debug
})

vim.keymap.set('n', '=t', require('treesj').toggle)
vim.keymap.set('n', '=T', function()
    require('treesj').toggle({ split = { recursive = true } })
end)
vim.keymap.set('n', '=j', require('treesj').join)
vim.keymap.set('n', '=J', function()
    require('treesj').join({ split = { recursive = true } })
end)
vim.keymap.set('n', '=s', require('treesj').split)
vim.keymap.set('n', '=J', function()
    require('treesj').split({ split = { recursive = true } })
end)
