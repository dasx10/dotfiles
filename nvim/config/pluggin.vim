call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'jacoborus/tender.vim'
" syntax

Plug 'editorconfig/editorconfig-vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'lilydjwg/colorizer'
Plug 'luochen1990/rainbow' "bracket
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'AndrewRadev/tagalong.vim'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
call plug#end()

let g:coc_global_extensions = [
\ 'coc-tsserver',
\ 'coc-highlight',
\ 'coc-json',
\ 'coc-eslint',
\ 'coc-pairs',
\ 'coc-css',
\ 'coc-cssmodules',
\ 'coc-stylelintplus',
\ 'coc-html',
\ 'coc-htmlhint',
\ 'coc-emmet',
\ 'coc-explorer',
\ 'coc-snippets',
\ 'coc-tabnine',
\ 'coc-spell-checker',
\ 'coc-webpack',
\ 'coc-svg',
\ 'coc-xml',
\ 'coc-vetur',
\ 'coc-vimlsp',
\ 'coc-zi',
\ ]
