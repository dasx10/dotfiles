call plug#begin('~/.vim/plugged')
" themes
" Plug 'larsbs/vimterial_dark'
" Plug 'tomasiser/vim-code-dark'
" Plug 'morhetz/gruvbox'
Plug 'jacoborus/tender.vim'
" Plug 'wojciechkepka/vim-github-dark'
" Plug 'wuelnerdotexe/vim-enfocado'
" Plug 'tomasiser/vim-code-dark'
" update syntax
Plug 'luochen1990/rainbow' "bracket
Plug 'lilydjwg/colorizer'
Plug 'jbgutierrez/vim-better-comments'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'mxw/vim-jsx'
Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'
Plug 'othree/html5.vim'
Plug 'David-Kunz/markid'
" Plug 'storyn26383/vim-vue'
Plug 'posva/vim-vue'
Plug 'larsbs/vim-xmll'
Plug 'genoma/vim-less'
Plug 'mustache/vim-mustache-handlebars'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'editorconfig/editorconfig-vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
Plug 'AndrewRadev/tagalong.vim'
" Plug 'mileszs/ack.vim'
" Plug 'scrooloose/nerdtree'
" Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
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
