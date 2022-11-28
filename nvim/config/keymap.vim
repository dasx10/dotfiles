noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr>  (v:count == 0 ? 'g' : '')

imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
imap <silent><expr> <c-space> coc#refresh()

nnoremap <silent> Zq :q<cr>
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <F2> <Plug>(coc-rename)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)

" mouse map
map <silent><C-LeftMouse>    <Plug>(VM-Mouse-Cursor)
map <silent><A-RightMouse>   <Plug>(VM-Mouse-Word)
map <silent><M-C-RightMouse> <Plug>(VM-Mouse-Column)


"PLEADER MAP
let mapleader = "\<Space>"
" CoC
nmap <leader>t   <Cmd>CocCommand explorer<CR>
xmap <leader>x   <Plug>(coc-convert-snippet)
xmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>cf  <Plug>(coc-format-selected)
xmap <leader>cas <Plug>(coc-codeaction-selected)
nmap <leader>cas <Plug>(coc-codeaction-selected)
nmap <leader>ca  <Plug>(coc-codeaction)
nmap <leader>cx  <Plug>(coc-fix-current)
nnoremap <silent><leader>cd :<C-u>CocList diagnostics<cr>
nnoremap <silent><leader>ce :<C-u>CocList extensions<cr>
nnoremap <silent><leader>co :<C-u>CocList outline<cr>
nnoremap <silent><leader>cs :<C-u>CocList -I symbols<cr>
nnoremap <silent><leader>cn :<C-u>CocNext<CR>
nnoremap <silent><leader>cN :<C-u>CocPrev<CR>
nnoremap <silent><leader>cr :<C-u>CocListResume<CR>
nnoremap <silent><leader><space> :<C-u>CocList commands<cr>

" Git
nmap <leader>ghp <Plug>(GitGutterPreviewHun)
nmap <leader>ghs <Plug>(GitGutterStageHun)
nmap <leader>ghu <Plug>(GitGutterUndoHun)
nmap <leader>g   :Git<space>
nmap <leader>ga  :Git add<space>
nmap <leader>ga% :Git add %<CR>
nmap <leader>gam :Git commit -am<space>
nmap <leader>gP  :Git pull<space>
nmap <leader>gPo :Git pull origin<space>
nmap <leader>gb  :Git branch<space>
nmap <leader>gc  :Git commit<space>
nmap <leader>gcm :Git commit -m ""<left>
nmap <leader>gco :Git checout<space>
nmap <leader>gm  :Git merge<space>
nmap <leader>gr  :Git rebase<space>
nmap <leader>gn  :Git checout -b<space>
nmap <leader>gmo :Git merge origin<space>
nmap <leader>gp  :Git push<space>
nmap <leader>gpo :Git push origin<space>
nmap <silent><leader>gg :Git<CR>
nmap <silent><leader>gA :Git add -A<CR>
nmap <silent><leader>gd :Git diff<CR>
nmap <silent><leader>gds :Gdiffsplit<CR>
nmap <silent><leader>gl :Git log<CR>
nmap <silent><leader>gs :Git status<CR>
nmap <leader>gf :Git fetch<CR>

" Searching
nmap <silent><leader>od <Plug>(coc-definition)
nmap <silent><leader>ot <Plug>(coc-type-definition)
nmap <silent><leader>oi <Plug>(coc-implementation)
nmap <silent><leader>or <Plug>(coc-references)
nmap <silent><leader>oc :copen<CR>
nmap <silent><leader>og :registers<CR>
nmap <silent><leader>/ :nohlsearch<CR>

map <Leader>rn /[0-9]\+<CR>
map <leader>rw /[a-zA-Z]\+<CR>
map <leader>rc /[A-Z][a-z]\+<CR>
map <leader>ru /[A-Z]\+<CR>
map <leader>rl /[a-z]\+<CR>

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nmap <leader>w :write<CR>:Git add %<CR>:Git commit -m ""<left>

" Formating
xmap <silent><leader>fe :!node ~/.config/nvim/scripts/ru2en.js<CR>
nmap <silent><leader>fc V:!node ~/.config/nvim/scripts/toCamel.js<CR>
xmap <silent><leader>fc :!node ~/.config/nvim/scripts/toCamel.js<CR>
xmap <silent><leader>fm  :!node ~/.config/nvim/scripts/calc.js<CR>
nmap <silent><leader>fm V:!node ~/.config/nvim/scripts/calc.js<CR>

noremap <silent><C-s> :write<CR>
nmap <silent><C-t> :tabnew<CR>
vnoremap <silent><C-t> "ty:tabnew<CR>"tP
nnoremap <silent><C-c> :yan<CR>
vnoremap <silent><C-c> :yan<CR>gv
nmap <silent>gv :0<CR>VG

" ALT MAP
nnoremap <silent><A-k> :call ToUpRecursive()<cr>==
nnoremap <silent><A-j> :call ToDownRecursive()<cr>==
nnoremap <silent><A-g> :move 0<CR>==
nnoremap <silent><A-up> :move .-2<CR>==
nnoremap <silent><A-down> :move .+1<CR>==
nnoremap <silent><A-l> m0I<tab><esc>`0
nnoremap <silent><A-h> m0^2dh`0
nnoremap <silent><A-n> m0yyp`0j
nnoremap <silent><A-p> m0yyP`0k
nnoremap <silent><A-d> <Plug>(coc-range-select)
nnoremap <silent><A-n> :move<space>

vnoremap <silent><A-k> :move '<-2<CR>gv=gv
vnoremap <silent><A-j> :move '>+1<CR>gv=gv
vnoremap <silent><A-up> :move '<-2<CR>gv=gv
vnoremap <silent><A-down> :move '>+1<CR>gv=gv
vnoremap <silent><A-h> :normal ^2dh<cr>gv
vnoremap <silent><A-l> :normal I  <cr>gv
vnoremap <silent><A-n> :move<space>
vnoremap <silent><A-g> :move 0<CR>gb

xmap <silent><A-d> <Plug>(coc-range-select)

imap <silent><A-l> <right>
imap <silent><A-h> <left>
imap <silent><A-j> <down>
imap <silent><A-k> <up>

" Sort
vnoremap <leader>s  :sort<cr>gv=gv
nnoremap <leader>ss m0ggVG:sort<cr>`0==
nnoremap <leader>sp m0vip:sort<cr>`0==
nnoremap <leader>s{ m0vi{:sort<cr>`0==
nnoremap <leader>s[ m0vi[:sort<cr>`0==
nnoremap <leader>s( m0vi(:sort<cr>`0==
nnoremap <leader>s' m0vi':sort<cr>`0==
nnoremap <leader>s" m0vi":sort<cr>`0==
nnoremap <leader>s` m0vi`:sort<cr>`0==

" Sort uniq
vnoremap <leader>s  :sort u<cr>gv=gb
nnoremap <leader>sp m0vip:sort u<cr>`0==
nnoremap <leader>s( n0vi(:sort u<cr>`0==
nnoremap <leader>s[ n0vi[:sort u<cr>`0==
nnoremap <leader>ss m0ggvg:sort u<cr>`0==
nnoremap <leader>s{ n0vi{:sort u<cr>`0==
nnoremap <leader>S' n0vi':sort u<cr>`0==
nnoremap <leader>S" n0vi":sort u<cr>`0==
nnoremap <leader>S` n0vi`:sort u<cr>`0==

" Reverse
vnoremap <leader>r  :sort!<cr>gv=gv
nnoremap <leader>rs m0ggVG:sort!<cr>`0==
nnoremap <leader>rp m0vip:sort!<cr>`0==
nnoremap <leader>r{ n0vi{:sort!<cr>`0==
nnoremap <leader>r[ n0vi[:sort!<cr>`0==
nnoremap <leader>r( n0vi(:sort!<cr>`0==
nnoremap <leader>r' n0vi':sort!<cr>`0==
nnoremap <leader>r" n0vi":sort!<cr>`0==
nnoremap <leader>r` n0vi`:sort!<cr>`0==

" Reverse uniq
vnoremap <leader>R  :sort! u<cr>gv=gv
nnoremap <leader>Rr m0ggVG:sort! u<cr>`0==
nnoremap <leader>Rp m0vip:sort! u<cr>`0==
nnoremap <leader>R{ n0vi{:sort! u<cr>`0==
nnoremap <leader>R[ n0vi[:sort! u<cr>`0==
nnoremap <leader>R( n0vi(:sort! u<cr>`0==
nnoremap <leader>R' n0vi':sort! u<cr>`0==
nnoremap <leader>R" n0vi":sort! u<cr>`0==
nnoremap <leader>R` n0vi`:sort! u<cr>`0==

" Comments
" CTRL MAP
vnoremap <silent><C-/> :Commentary<CR>gv=gv
nnoremap <silent><C-/> :Commentary<CR>==
inoremap <silent><C-/> <esc>:Commentary<cr>

" TMUX FIX COMMENT
vnoremap <silent><C-_> :Commentary<CR>gv=gv
nnoremap <silent><C-_> :Commentary<CR>==
inoremap <silent><C-_> <esc>:Commentary<cr>a

vnoremap <leader>cc :Commentary<cr>gv=gv
nnoremap <leader>cc :Commentary<cr>

nnoremap <leader>cp m0vip=vip:Commentary<cr>`0
nnoremap <leader>c[ m0vi[=vi[:Commentary<cr>`0
nnoremap <leader>c{ m0vi{=vi{:Commentary<cr>`0
nnoremap <leader>c< m0vi<=vi<:Commentary<cr>`0
nnoremap <leader>c( m0vi(=vi(:Commentary<cr>`0
nnoremap <leader>c' m0vi'=vi':Commentary<cr>`0
nnoremap <leader>c" m0vi"=vi":Commentary<cr>`0
nnoremap <leader>c` m0vi`=vi`:Commentary<cr>`0

nnoremap <leader>cap m0vap=vap:Commentary<cr>`0
nnoremap <leader>ca[ m0va[=va[:Commentary<cr>`0
nnoremap <leader>ca{ m0va{=va{:Commentary<cr>`0
nnoremap <leader>ca< m0va<=va<:Commentary<cr>`0
nnoremap <leader>ca( m0va(=va(:Commentary<cr>`0
nnoremap <leader>ca( m0va(=va(:Commentary<cr>`0
nnoremap <leader>ca' m0va'=va':Commentary<cr>`0
nnoremap <leader>ca" m0va"=va":Commentary<cr>`0
nnoremap <leader>ca` m0va`=va`:Commentary<cr>`0

nnoremap <leader>cip m0vip=vip:Commentary<cr>`0
nnoremap <leader>ci[ m0vi[=vi[:Commentary<cr>`0
nnoremap <leader>ci{ m0vi{=vi{:Commentary<cr>`0
nnoremap <leader>ci< m0vi<=vi<:Commentary<cr>`0
nnoremap <leader>ci( m0vi(=vi(:Commentary<cr>`0
nnoremap <leader>ci( m0vi(=vi(:Commentary<cr>`0
nnoremap <leader>ci' m0vi'=vi':Commentary<cr>`0
nnoremap <leader>ci" m0vi"=vi":Commentary<cr>`0
nnoremap <leader>ci` m0vi`=vi`:Commentary<cr>`0

" Format
vnoremap =e ==:EasyAlign<cr><right>
vnoremap =<right> =gv:EasyAlign<cr><right>
vnoremap =<space> =gv:EasyAlign<cr>*<space>
vnoremap =: =gv:EasyAlign<cr><right>:
vnoremap =+ =gv:EasyAlign<cr><right>=
vnoremap =, =gv:EasyAlign<cr><right>,
vnoremap =. =gv:EasyAlign<cr><right>.

nnoremap =: vi{=vi{:EasyAlign<cr><right>:
nnoremap =+ vip=vip:EasyAlign<cr><right>=
nnoremap =<space> vip=vip:EasyAlign<cr>*<space>

nnoremap =. m0ggVG=`0
nnoremap =l :CocCommand eslint.executeAutofix<CR>
nnoremap =p :CocCommand prettier.formatFile<CR>
vnoremap =l :CocCommand eslint.executeAutofix<CR>
vnoremap =p :CocCommand prettier.formatFile<CR>

" Delete
nnoremap dp dip
nnoremap d. gg0VG$d
nnoremap d<space> :StripWhitespace<cr>
nnoremap d<cr> :g/^\s*$/d<CR>
nnoremap d<tab> m0^d0`0
nnoremap do vj:s/^\n//<cr>
nnoremap dO V:s/^\n//<cr>
nnoremap dy m0<C-v>ggoGx`0
nnoremap d# m0"0yiwVgg:s/<C-r>0//g<cr>`0:nog<cr>
nnoremap d! m0"0yiw:%s/<C-r>0//<cr>`0:noh<cr>
nnoremap d* m0"0yiwVG:s/<C-r>0//g<cr>`0:noh<cr>
nnoremap dv gvd
nnoremap d/ :%s/<C-r>///<cr>
nnoremap dc m0"0yl:%s/<C-r>0//<cr>

vnoremap D<cr> :g/^\s*$/d<CR>gv
vnoremap D<space> :StripWhitespace<cr>gv
vnoremap D<tab> :normal ^d0<cr>
vnoremap DV m0d:%s/<C-r>"//<cr>`0

" Fold
nnoremap z* Vggzf
nnoremap z# VGzf
nnoremap z( va(zf
nnoremap z< va<zf
nnoremap z[ va[zf
nnoremap z{ va{zf
nnoremap z" va"zf
nnoremap z' va'zf
nnoremap z` va`zf
nnoremap zp vipzfzz

" Visual
nnoremap vp vip
nnoremap v. :0<CR>VG
nnoremap v/ G$n<C-v>N
nnoremap v! gg<C-v>Gzt
nnoremap v# m0gg<C-v>`0zb
nnoremap v* m0G<C-v>`0zt

" Change
nnoremap cp cip
nnoremap c. ggVGs
nnoremap c# "0yiwVgg:s/<C-r>0//cg<left><left><left>
nnoremap c! "0yiw:%s/<C-r>0//cg<left><left><left>
nnoremap c* "0yiwVG:s/<C-r>0//cg<left><left><left>
vnoremap C  "0y:%s/<C-r>0//cg<left><left><left>

" Copy
nnoremap yp yip
nnoremap yd :let @+ = expand("%")<cr>
nnoremap y. m0ggVGy`0

" Other
nmap <silent><Home> :1<CR>
nmap <silent><End> :$<CR>
xmap <silent><Home> :1<CR>
xmap <silent><End> :$<CR>

nmap <C-space> :call ShowDocumentation()<CR>
nmap <silent><leader>vn :call CheckboxRelative()<cr>
nmap <silent><leader>vc :call CheckboxSpaceHighlight()<cr>
xmap <silent><leader>/  "hy/<C-r>h<CR>
xmap <silent><leader>?  "hy?<C-r>h<CR>

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
imap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
