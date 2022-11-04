noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
imap <silent><expr> <c-space> coc#refresh()
imap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

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

" LEADER MAP
let mapleader = "\<Space>"
" CoC
nmap <leader>e   <Cmd>CocCommand explorer<CR>
xmap <leader>x   <Plug>(coc-convert-snippet)
xmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>cf  <Plug>(coc-format-selected)
xmap <leader>cas <Plug>(coc-codeaction-selected)
nmap <leader>cas <Plug>(coc-codeaction-selected)
nmap <leader>ca  <Plug>(coc-codeaction)
nmap <leader>cx  <Plug>(coc-fix-current) nnoremap <silent><leader>cd :<C-u>CocList diagnostics<cr>
nnoremap <silent><leader>ce :<C-u>CocList extensions<cr>
nnoremap <silent><leader>co :<C-u>CocList outline<cr>
nnoremap <silent><leader>cs :<C-u>CocList -I symbols<cr>
nnoremap <silent><leader>cn :<C-u>CocNext<CR>
nnoremap <silent><leader>cN :<C-u>CocPrev<CR>
nnoremap <silent><leader>cr :<C-u>CocListResume<CR>
nnoremap <silent><leader><space> :<C-u>CocList commands<cr>

" Git
nmap <leader>ghp <Plug>(GitGutterPreviewHunk)
nmap <leader>ghs <Plug>(GitGutterStageHunk)
nmap <leader>ghu <Plug>(GitGutterUndoHunk)
nmap <leader>g   :Git<space>
nmap <leader>ga  :Git add<space>
nmap <leader>ga% :Git add %<CR>
nmap <leader>gam :Git commit -am<space>
nmap <leader>gP  :Git pull<space>
nmap <leader>gPo :Git pull origin<space>
nmap <leader>gb  :Git branch<space>
nmap <leader>gc  :Git commit<space>
nmap <leader>gcm :Git commit -m ""<left>
nmap <leader>gco :Git checkout<space>
nmap <leader>gm  :Git merge<space>
nmap <leader>gr  :Git rebase<space>
nmap <leader>gn  :Git checkout -b<space>
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
nmap <silent><leader>od 2h/"[^"]\+"\\|'[^']\+'<cr>Nnl:noh<cr><Plug>(coc-definition)
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
nnoremap <silent><leader>fa <Plug>(EasyAlign)
vnoremap <silent><leader>fa <Plug>(EasyAlign)
vnoremap <silent><leader>f: <Plug>(EasyAlign)<right>:
nnoremap <silent><leader>f: m0vi{<Plug>(EasyAlign)<right>:`0
vnoremap <silent><leader>f= <Plug>(EasyAlign)<right>=
vnoremap <silent><leader>f, <Plug>(EasyAlign)<right>,

nmap <silent><leader>fl :CocCommand eslint.executeAutofix<CR>
xmap <silent><leader>fl :CocCommand eslint.executeAutofix<CR>
nmap <silent><leader>fp :CocCommand prettier.formatFile<CR>
xmap <silent><leader>fp :CocCommand prettier.formatFile<CR>
xmap <silent><leader>fe :!node ~/.config/nvim/scripts/ru2en.js<CR>
nmap <silent><leader>fc V:!node ~/.config/nvim/scripts/toCamel.js<CR>
xmap <silent><leader>fc :!node ~/.config/nvim/scripts/toCamel.js<CR>
xmap <silent><leader>fm  :!node ~/.config/nvim/scripts/calc.js<CR>
nmap <silent><leader>fm V:!node ~/.config/nvim/scripts/calc.js<CR>

noremap <silent><C-s> :write<CR>
nmap <silent><C-t> :tabnew<CR>
vnoremap <silent><C-t> "ty:tabnew<CR>"tP
nnoremap <silent><C-c> :yank<CR>
vnoremap <silent><C-c> :yank<CR>gv
nmap <silent>gv :0<CR>VG

" ALT MAP
nnoremap <silent><A-k> :move .-2<CR>==
nnoremap <silent><A-j> :move .+1<CR>==
nnoremap <silent><A-up> :move .-2<CR>==
nnoremap <silent><A-down> :move .+1<CR>==

nmap <silent><A-d> <Plug>(coc-range-select)
nmap <silent><A-g> :move 0<CR>
nmap <silent><A-n> :move<space>
nmap <silent><A-l> m0I<tab><esc>`0
nmap <silent><A-h> m0^2dh`0
nmap <silent><A-n> yyp
nmap <silent><A-p> yyP

vnoremap <silent><A-j> :move '>+1<CR>gv=gv
vnoremap <silent><A-up> :move '<-2<CR>gv=gv
vnoremap <silent><A-down> :move '>+1<CR>gv=gv
vnoremap <silent><A-k> :move '<-2<CR>gv=gv
vnoremap <silent><A-h> :normal ^2dh<cr>gv
vnoremap <silent><A-l> :normal I  <CR>gv
vnoremap <silent><A-n> :move<space>
vnoremap <silent><A-g> :move 0<CR>gb

xmap <silent><A-d> <Plug>(coc-range-select)

imap <silent><A-l> <right>
imap <silent><A-h> <left>

" Sort
vnoremap <leader>s  :sort<cr>gv
nnoremap <leader>ss m0ggVG:sort<cr>`0
nnoremap <leader>sp m0vip:sort<cr>`0
nnoremap <leader>s{ n0vi{:sort<cr>`0
nnoremap <leader>s[ n0vi[:sort<cr>`0
nnoremap <leader>s( n0vi(:sort<cr>`0
nnoremap <leader>s' n0vi':sort<cr>`0
nnoremap <leader>s" n0vi":sort<cr>`0
nnoremap <leader>s` n0vi`:sort<cr>`0

" Sort uniq
vnoremap <leader>S  :sort u<cr>gv
nnoremap <leader>Ss m0ggVG:sort u<cr>`0
nnoremap <leader>Sp m0vip:sort u<cr>`0
nnoremap <leader>S{ n0vi{:sort u<cr>`0
nnoremap <leader>S[ n0vi[:sort u<cr>`0
nnoremap <leader>S( n0vi(:sort u<cr>`0
nnoremap <leader>S' n0vi':sort u<cr>`0
nnoremap <leader>S" n0vi":sort u<cr>`0
nnoremap <leader>S` n0vi`:sort u<cr>`0

" Reverse
vnoremap <leader>r  :sort!<cr>gv
nnoremap <leader>rs m0ggVG:sort!<cr>`0
nnoremap <leader>rp m0vip:sort!<cr>`0
nnoremap <leader>r{ n0vi{:sort!<cr>`0
nnoremap <leader>r[ n0vi[:sort!<cr>`0
nnoremap <leader>r( n0vi(:sort!<cr>`0
nnoremap <leader>r' n0vi':sort!<cr>`0
nnoremap <leader>r" n0vi":sort!<cr>`0
nnoremap <leader>r` n0vi`:sort!<cr>`0

" Reverse uniq
vnoremap <leader>R  :sort! u<cr>gv
nnoremap <leader>Rr m0ggVG:sort! u<cr>`0
nnoremap <leader>Rp m0vip:sort! u<cr>`0
nnoremap <leader>R{ n0vi{:sort! u<cr>`0
nnoremap <leader>R[ n0vi[:sort! u<cr>`0
nnoremap <leader>R( n0vi(:sort! u<cr>`0
nnoremap <leader>R' n0vi':sort! u<cr>`0
nnoremap <leader>R" n0vi":sort! u<cr>`0
nnoremap <leader>R` n0vi`:sort! u<cr>`0


" Comments
" CTRL MAP
vnoremap <silent><C-/> :Commentary<CR>gv=gv
nnoremap <silent><C-/> :Commentary<CR>
inoremap <silent><C-/> <esc>:Commentary<cr>a
" TMUX FIX COMMENT
vnoremap <silent><C-_> :Commentary<CR>gv=gv
nnoremap <silent><C-_> :Commentary<CR>
inoremap <silent><C-_> <esc>:Commentary<cr>a

vnoremap <leader>c :Commentary<cr>gv
nnoremap <leader>cc :Commentary<cr>
nnoremap <leader>cp/ I//<esc>
nnoremap <leader>cd/ ^2ld2F/

nnoremap <leader>cp m0vip:Commentary<cr>`0
nnoremap <leader>c[ m0vi[:Commentary<cr>`0
nnoremap <leader>c{ m0vi{:Commentary<cr>`0
nnoremap <leader>c< m0vi<:Commentary<cr>`0
nnoremap <leader>c( m0vi(:Commentary<cr>`0
nnoremap <leader>c' m0vi':Commentary<cr>`0
nnoremap <leader>c" m0vi":Commentary<cr>`0
nnoremap <leader>c` m0vi`:Commentary<cr>`0

nnoremap <leader>cap m0vap:Commentary<cr>`0
nnoremap <leader>ca[ m0va[:Commentary<cr>`0
nnoremap <leader>ca{ m0va{:Commentary<cr>`0
nnoremap <leader>ca< m0va<:Commentary<cr>`0
nnoremap <leader>ca( m0va(:Commentary<cr>`0
nnoremap <leader>ca( m0va(:Commentary<cr>`0
nnoremap <leader>ca' m0va':Commentary<cr>`0
nnoremap <leader>ca" m0va":Commentary<cr>`0
nnoremap <leader>ca` m0va`:Commentary<cr>`0

nnoremap <leader>cip m0vip:Commentary<cr>`0
nnoremap <leader>ci[ m0vi[:Commentary<cr>`0
nnoremap <leader>ci{ m0vi{:Commentary<cr>`0
nnoremap <leader>ci< m0vi<:Commentary<cr>`0
nnoremap <leader>ci( m0vi(:Commentary<cr>`0
nnoremap <leader>ci( m0vi(:Commentary<cr>`0
nnoremap <leader>ci' m0vi':Commentary<cr>`0
nnoremap <leader>ci" m0vi":Commentary<cr>`0
nnoremap <leader>ci` m0vi`:Commentary<cr>`0

" Delete
nnoremap d{ di{
nnoremap d[ di[
nnoremap d< di<
nnoremap d( di(
nnoremap d} da}
nnoremap d] da]
nnoremap d) da)
nnoremap d> da>
nnoremap d" di"
nnoremap d' di'
nnoremap d` di`
nnoremap dp dip
nnoremap d. gg0VG$d
nnoremap d<space> :StripWhitespace<cr>
nnoremap d<cr> :g/^\s*$/d<CR>
vnoremap D<cr> :g/^\s*$/d<CR>gv
vnoremap D<space> :StripWhitespace<cr>gv

" Fold
nnoremap z( va(zf
nnoremap z< va<zf
nnoremap z[ va[zf
nnoremap z{ va{zf
nnoremap z" va"zf
nnoremap z' va'zf
nnoremap z` va`zf
nnoremap zp vipzf2w

" Visual
nnoremap v{ vi{
nnoremap v[ vi[
nnoremap v( vi(
nnoremap v< vi<
nnoremap v} va}
nnoremap v] va]
nnoremap v) va)
nnoremap v> va>
nnoremap v' vi'
nnoremap v" vi"
nnoremap v` vi`
nnoremap vp vip
nnoremap v. :0<CR>VG

" Change
nnoremap c' ci'
nnoremap c" ci"
nnoremap c` ci`
nnoremap cp cip
nnoremap c[ ci[
nnoremap c{ ci{
nnoremap c( ci(
nnoremap c< ci<
nnoremap c} ca}
nnoremap c] ca]
nnoremap c) ca)
nnoremap c> ca>
nnoremap c. ggVGs
vnoremap C <right>"cy:%s/<C-r>c<BS>//cg<left><left><left>

" Copy
nnoremap y{ yi{
nnoremap y[ yi[
nnoremap y( yi(
nnoremap y< yi<
nnoremap y} ya}
nnoremap y] ya]
nnoremap y) ya)
nnoremap y> ya>
nnoremap y" yi"
nnoremap y' yi'
nnoremap y` yi`
nnoremap yd :let @+ = expand("%")<CR>:echo "Copy directory ".expand("%")<CR>
nnoremap y. m0ggVGy`0

" Other
nmap <silent><Home> :1<CR>
nmap <silent><End> :$<CR>
xmap <silent><Home> :1<CR>
xmap <silent><End> :$<CR>

nmap <C-space> :call ShowDocumentation()<CR>
nmap <silent><leader>vn :call NumberToggle()<CR>
nmap <silent><leader>vc :call CharToggle()<CR>
xmap <silent><leader>/  "hy/<C-r>h<CR>
xmap <silent><leader>?  "hy?<C-r>h<CR>

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
