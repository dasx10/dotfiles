" inoremap jk <ESC>
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
nmap <silent> Zq :q<CR>
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
nnoremap <silent><leader>cc :<C-u>CocList commands<cr>
nnoremap <silent><leader>co :<C-u>CocList outline<cr>
nnoremap <silent><leader>cs :<C-u>CocList -I symbols<cr>
nnoremap <silent><leader>cn :<C-u>CocNext<CR>
nnoremap <silent><leader>cN :<C-u>CocPrev<CR>
nnoremap <silent><leader>cr :<C-u>CocListResume<CR>

" Git
nmap <leader>ghp <Plug>(GitGutterPreviewHunk)
nmap <leader>ghs <Plug>(GitGutterStageHunk)
nmap <leader>ghu <Plug>(GitGutterUndoHunk)
nmap <leader>g  :Git<space>
nmap <leader>ga :Git add<space>
nmap <leader>ga% :Git add %<CR>
nmap <leader>gam :Git commit -am<space>
nmap <leader>gP :Git pull<space>
nmap <leader>gPo :Git pull origin<space>
nmap <leader>gb :Git branch<space>
nmap <leader>gcc :Git commit<space>
nmap <leader>gcm :Git commit -m ""<left>
nmap <leader>gco :Git checkout<space>
nmap <leader>gm :Git merge<space>
nmap <leader>gn :Git checkout -b<space>
nmap <leader>gmo :Git merge origin<space>
nmap <leader>gp :Git push<space>
nmap <leader>gpo :Git push origin<space>
nmap <silent><leader>G  :Git<CR>
nmap <silent><leader>gA :Git add -A<CR>
nmap <silent><leader>gd :Git diff<CR>
nmap <silent><leader>gds :Gdiffsplit<CR>
nmap <silent><leader>gl :Git log<CR>
nmap <silent><leader>gr :Git rebase<CR>
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
map <Leader>ff :Files<CR>
map <Leader>fb :BLines<CR>
map <Leader>fg :Rg<CR>
map <Leader>rn /[0-9]\+<CR>
map <leader>rw /[a-zA-Z]\+<CR>
map <leader>rc /[A-Z][a-z]\+<CR>
map <leader>ru /[A-Z]\+<CR>
map <leader>rl /[a-z]\+<CR>

nmap <leader>w :write<CR>:Git add %<CR>:Git commit -m ""<left>

" Formating
nmap <backspace> s<esc>
xmap <leader>cg "hy:%s/<C-r>h<BS>//cg<left><left><left>
nmap <leader>cg viw "hy:%s/<C-r>h<BS>//cg<left><left><left>
nmap <silent><leader>fa <Plug>(EasyAlign)
xmap <silent><leader>fa <Plug>(EasyAlign)
xmap <silent><leader>f: <Plug>(EasyAlign)<right>:
nmap <silent><leader>f: vi{<Plug>(EasyAlign)<right>:
xmap <silent><leader>f= <Plug>(EasyAlign)<right>=
xmap <silent><leader>f, <Plug>(EasyAlign)<right>,
xmap <silent><leader>fs :sort<CR>
xmap <silent><leader>fr :sort!<CR>
xmap <silent><leader>fu :sort u<CR>
xmap <silent><leader>fw :StripWhitespace<CR>
nmap <silent><leader>fw :StripWhitespace<CR>
nmap <silent><leader>fl :CocCommand eslint.executeAutofix<CR>
xmap <silent><leader>fl :CocCommand eslint.executeAutofix<CR>
nmap <silent><leader>fp :CocCommand prettier.formatFile<CR>
xmap <silent><leader>fp :CocCommand prettier.formatFile<CR>
xmap <silent><leader>fe :!node ~/.config/nvim/scripts/ru2en.js<CR>
nmap <silent><leader>fcc V:!node ~/.config/nvim/scripts/toCamel.js<CR>
xmap <silent><leader>fcc :!node ~/.config/nvim/scripts/toCamel.js<CR>
xmap <silent><leader>fm  :!node ~/.config/nvim/scripts/calc.js<CR>
nmap <silent><leader>fm V:!node ~/.config/nvim/scripts/calc.js<CR>
nmap <silent><leader>fn :g/^\s*$/d<CR>
xmap <silent><leader>fn :g/^\s*$/d<CR>

" CTRL MAP
xmap <silent><C-_> :Commentary<CR>
nmap <silent><C-_> :Commentary<CR>
xmap <silent><C-s> :write<CR>
nmap <silent><C-s> :write<CR>
xmap <silent><C-t> :tabnew<CR>
nmap <silent><C-t> :tabnew<CR>
nmap <silent><C-c> :yank<CR>
xmap <silent><C-c> :yank<CR>
nmap <silent>gv :0<CR>VG

" ALT MAP
nmap <silent> <A-d> <Plug>(coc-range-select)
xmap <silent> <A-d> <Plug>(coc-range-select)
vnoremap <silent><A-k> :move '<-2<CR>gv=gv
nnoremap <silent><A-k> :move .-2<CR>==
vnoremap <silent><A-j> :move '>+1<CR>gv=gv
nnoremap <silent><A-j> :move .+1<CR>==
vnoremap <silent><A-up> :move '<-2<CR>gv=gv
nnoremap <silent><A-up> :move .-2<CR>==
vnoremap <silent><A-down> :move '>+1<CR>gv=gv
nnoremap <silent><A-down> :move .+1<CR>==
nmap <silent><A-g> :move 0<CR>
xmap <silent><A-g> :move 0<CR>
nmap <silent><A-n> :move<space>
xmap <silent><A-n> :move<space>
nmap <silent><A-l> I<tab><esc>
xmap <silent><A-l> :normal I  <CR>
nmap <silent><A-h> ^2dh
nmap <silent><A-n> yyp
nmap <silent><A-p> yyP
imap <silent><A-l> <right>
imap <silent><A-h> <left>

" Delete
nmap d" di"
nmap d' di'
nmap d` di`
nmap d{ di{
nmap d[ di[
nmap d< di<
nmap d( di(

" Fold
nmap z" va"zf
nmap z' va'zf
nmap z` va`zf
nmap z( va(zf
nmap z< va<zf
nmap z[ va[zf
nmap z{ va{zf
nmap zp vipzf

" Visual
nmap v{ vi{
nmap v[ vi[
nmap v( vi(
nmap v< vi<
nmap v' vi'
nmap v" vi"
nmap v` vi`
nmap vp vip
nmap v% :0<CR>VG

" Change
nmap c' ci'
nmap c" ci"
nmap c` ci`
nmap cp cip
nmap c[ ci[
nmap c{ ci{
nmap c( ci(
nmap c< ci<
nmap c% ggVGs

" Copy
nmap yd :let @+ = expand("%")<CR>:echo "Copy directory ".expand("%")<CR>
nmap y% m0ggVGy'0
nmap y{ yi{
nmap y[ yi[
nmap y( yi(
nmap y< yi<
nmap y" yi"
nmap y' yi'
nmap y` yi`

" Other
map <silent><Home> :1<CR>
map <silent><End> :$<CR>
nmap <silent><leader>i :call ShowDocumentation()<CR>
xmap <silent><leader>i :call ShowDocumentation()<CR>
nmap <silent><leader>vn :call NumberToggle()<CR>
nmap <silent><leader>vc :call CharToggle()<CR>
xmap <silent><leader>/  "hy/<C-r>h<CR>
xmap <silent><leader>?  "hy?<C-r>h<CR>

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
