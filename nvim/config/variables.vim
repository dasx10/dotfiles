let g:VM_mouse_mappings = 1
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<A-f>'           " replace C-n
let g:VM_maps['Find Subword Under'] = '<A-f>'           " replace visual C-n
let g:ctrlp__command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_custom_ignore = {
            \ 'dir': '\v[\/](\.git|\.hg|\.svn|\.vscode|\.idea)$',
            \ 'file': '\.swp$\|\.pyo$',
            \ }
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
let g:bettercomments_language_aliases = { 'javascript': 'js', 'typescript': 'ts', 'vue': 'vue' }
let g:coc_snippet_next = '<C-j>'
let g:coc_snippet_prev = '<C-k>'
