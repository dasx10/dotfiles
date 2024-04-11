nvim_set_keymap = vim.api.nvim_set_keymap;

nvim_set_keymap('n', 'ysof', "ca{Object.freeze(<Esc>p%a)<Esc>", {noremap = true, silent = true})
nvim_set_keymap('n', 'csl', "yiwoconsole.log()<Esc>P", {noremap = true, silent = true})
nvim_set_keymap('n', 'csd', "yiwoconsole.dir({  }, { depth: 10 })<Esc>18hp", {noremap = true, silent = true})

nvim_set_keymap('n', 'j', "(v:count == 0 ? 'gj' : 'j')", {noremap = true, silent = true, expr = true})
nvim_set_keymap('n', ')', "(v:count == 0 ? 'g' : '')", {noremap = true, silent = true, expr = true})

nvim_set_keymap('n', 'Zq', ':q<CR>', {noremap = true, silent = true})
nvim_set_keymap('n', '[g', '<Plug>(coc-diagnostic-prev)', {noremap = true, silent = true})
nvim_set_keymap('n', ']g', '<Plug>(coc-diagnostic-next)', {noremap = true, silent = true})
nvim_set_keymap('n', '<F2>', '<Plug>(coc-rename)', {noremap = true, silent = true})

-- Create mappings for function text object, requires document symbols feature of languageserver.
nvim_set_keymap('x', 'if', '<Plug>(coc-funcobj-i)', {noremap = true})
nvim_set_keymap('o', 'if', '<Plug>(coc-funcobj-i)', {noremap = true})
nvim_set_keymap('x', 'af', '<Plug>(coc-funcobj-a)', {noremap = true})
nvim_set_keymap('o', 'af', '<Plug>(coc-funcobj-a)', {noremap = true})

-- Mouse map
nvim_set_keymap('n', '<C-LeftMouse>', '<Plug>(VM-Mouse-Cursor)', {noremap = true, silent = true})
nvim_set_keymap('n', '<A-RightMouse>', '<Plug>(VM-Mouse-Word)', {noremap = true, silent = true})
nvim_set_keymap('n', '<M-C-RightMouse>', '<Plug>(VM-Mouse-Column)', {noremap = true, silent = true})

-- PLEADER MAP
vim.g.mapleader = " "
nvim_set_keymap('n', '<leader><cr>', ':.!zsh<cr>', {noremap = true})
-- CoC
nvim_set_keymap('x', '<leader>x', '<Plug>(coc-convert-snippet)', {noremap = true})
nvim_set_keymap('x', '<leader>cf', '<Plug>(coc-format-selected)', {noremap = true})
nvim_set_keymap('n', '<leader>cf', '<Plug>(coc-format-selected)', {noremap = true})
nvim_set_keymap('x', '<leader>cas', '<Plug>(coc-codeaction-selected)<cr>', {noremap = true})
nvim_set_keymap('n', '<leader>cas', '<Plug>(coc-codeaction-selected)', {noremap = true})
nvim_set_keymap('n', '<leader>ca', '<Plug>(coc-codeaction)', {noremap = true})
nvim_set_keymap('n', '<leader>cx', '<Plug>(coc-fix-current)', {noremap = true})
nvim_set_keymap('n', '<leader>cd', ':<C-u>CocList diagnostics<cr>', {silent = true, noremap = true})
nvim_set_keymap('n', '<leader>ce', ':<C-u>CocList extensions<cr>', {silent = true, noremap = true})
nvim_set_keymap('n', '<leader>co', ':<C-u>CocList outline<cr>', {silent = true, noremap = true})
nvim_set_keymap('n', '<leader>cs', ':<C-u>CocList -I symbols<cr>', {silent = true, noremap = true})
nvim_set_keymap('n', '<leader>cn', ':<C-u>CocNext<CR>', {silent = true, noremap = true})
nvim_set_keymap('n', '<leader>cN', ':<C-u>CocPrev<CR>', {silent = true, noremap = true})
nvim_set_keymap('n', '<leader>cr', ':<C-u>CocListResume<CR>', {silent = true, noremap = true})
nvim_set_keymap('n', '<leader><space>', ':<C-u>CocList commands<cr>', {silent = true, noremap = true})

-- Git
nvim_set_keymap('n', '<leader>g',        ':Git<space>', {})
nvim_set_keymap('n', '<leader>g<space>', ':Git blame<cr>', {})
nvim_set_keymap('n', '<leader>gA',       ':Git add -A<CR>', { silent = true })
nvim_set_keymap('n', '<leader>ga',       ':Git add<space>', { silent = true })
nvim_set_keymap('n', '<leader>gP',       ':Git pull<space>', {})
nvim_set_keymap('n', '<leader>gPo',      ':Git pull origin<space>', {})
nvim_set_keymap('n', '<leader>gPP',      ':!git pull origin $(git branch --show-current)<cr>', {})
nvim_set_keymap('n', '<leader>gmm',      ':!git pull origin $(git branch --show-current) && git merge origin $(git branch --show-current)<cr>', {})
nvim_set_keymap('n', '<leader>gp',       ':Git push<space>', {})
nvim_set_keymap('n', '<leader>gpo',      ':Git push origin<space>', {})
nvim_set_keymap('n', '<leader>gpp',      ':!git push origin $(git branch --show-current)<cr>', {})
nvim_set_keymap(
  'n',
  '<leader>gap',
  ':!git add -A && git commit -m "" && git push origin $(git branch --show-current)<left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>',
  {}
)
nvim_set_keymap('n', '<leader>ga%',      ':Git add %<CR>', {})
nvim_set_keymap('n', '<leader>ga',       ':Git add<space>', {})
nvim_set_keymap('n', '<leader>gam',      ':Git commit -am<space>', {})
nvim_set_keymap('n', '<leader>gb',       ':Git branch<space>', {})
nvim_set_keymap('n', '<leader>gc',       ':Git commit<space>', {})
nvim_set_keymap('n', '<leader>gcm',      ':Git commit -m ""<left>', {})
nvim_set_keymap('n', '<leader>gd',       ':Git diff<CR>', { silent = true })
nvim_set_keymap('n', '<leader>gdh',      ':Gdiffsplit<CR>', { silent = true })
nvim_set_keymap('n', '<leader>gds',      ':Gvdiffsplit<CR>', { silent = true })
nvim_set_keymap('n', '<leader>gdv',      ':Gdiffsplit<CR>', { silent = true })
nvim_set_keymap('n', '<leader>gf',       ':Git fetch<CR>', {})
nvim_set_keymap('n', '<leader>gg',       ':Git<CR>', { silent = true })
nvim_set_keymap('n', '<leader>ghp',      '<Plug>(GitGutterPreviewHun)', {})
nvim_set_keymap('n', '<leader>ghs',      '<Plug>(GitGutterStageHun)', {})
nvim_set_keymap('n', '<leader>ghu',      '<Plug>(GitGutterUndoHun)', {})
nvim_set_keymap('n', '<leader>gl',       ':Git log<CR>', { silent = true })
nvim_set_keymap('n', '<leader>gm',       ':Git merge<space>', {})
nvim_set_keymap('n', '<leader>gmo',      ':Git merge origin<space>', {})
nvim_set_keymap('n', '<leader>gn',       ':Git checkout -b<space>', {})
nvim_set_keymap('n', '<leader>go',       ':Git checkout<space>', {})
nvim_set_keymap('n', '<leader>gr',       ':Git rebase<space>', {})
nvim_set_keymap('n', '<leader>gro',      ':Git push origin :<left>', {})
nvim_set_keymap('n', '<leader>gs',       ':Git status<CR>', { silent = true })

-- Searching
nvim_set_keymap('n', '<leader>od', '<Plug>(coc-definition)', {silent = true})
nvim_set_keymap('n', '<leader>ot', '<Plug>(coc-type-definition)', {silent = true})
nvim_set_keymap('n', '<leader>oi', '<Plug>(coc-implementation)', {silent = true})
nvim_set_keymap('n', '<leader>or', '<Plug>(coc-references)', {silent = true})
nvim_set_keymap('n', '<leader>oc', ':copen<CR>', {silent = true})
nvim_set_keymap('n', '<leader>og', ':registers<CR>', {silent = true})
nvim_set_keymap('n', '<leader>/', ':nohlsearch<CR>', {silent = true})

nvim_set_keymap('n', '<leader>rn', '/[0-9]\\+<CR>', {silent = true})
nvim_set_keymap('n', '<leader>rw', '/[a-zA-Z]\\+<CR>', {silent = true})
nvim_set_keymap('n', '<leader>rc', '/[A-Z][a-z]\\+<CR>', {silent = true})
nvim_set_keymap('n', '<leader>ru', '/[A-Z]\\+<CR>', {silent = true})
nvim_set_keymap('n', '<leader>rl', '/[a-z]\\+<CR>', {silent = true})

nvim_set_keymap('n', '<leader>fot', '/<[a-z]\\+ [a-z=\'"]\\+ [a-z\'"]\\+<cr>', {silent = true})

nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<cr>', {silent = true})
nvim_set_keymap('n', '<leader>fw', ':Telescope live_grep<cr>', {silent = true})
nvim_set_keymap('n', '<leader>fh', ':Telescope help_tags<cr>', {silent = true})
nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<cr>', {silent = true})
nvim_set_keymap('n', "<leader>f'", ':Telescope marks<cr>', { silent = true })
nvim_set_keymap('n', '<leader>fgb', ':Telescope git_branches<cr>', {silent = true})
nvim_set_keymap('n', '<leader>fgc', ':Telescope git_commits<cr>', {silent = true})


nvim_set_keymap('n', '<leader>t', ':Vifm <cr>', { silent = true })

-- Formating
nvim_set_keymap('x', '<leader>fe', ':!node ~/.config/nvim/scripts/ru2en.js<CR>', {silent=true})
nvim_set_keymap('n', '<leader>fc', 'V:!node ~/.config/nvim/scripts/toCamel.js<CR>', {silent=true})
nvim_set_keymap('x', '<leader>fc', ':!node ~/.config/nvim/scripts/toCamel.js<CR>', {silent=true})
nvim_set_keymap('x', '<leader>fm', ':!node ~/.config/nvim/scripts/calc.js<CR>', {silent=true})
nvim_set_keymap('n', '<leader>fm', 'V:!node ~/.config/nvim/scripts/calc.js<CR>', {silent=true})
nvim_set_keymap('x', '<leader>fi', ':!node ~/.config/nvim/scripts/import.js<CR>', {silent=true})
nvim_set_keymap('n', '<leader>fi', 'V:!node ~/.config/nvim/scripts/import.js<CR>', {silent=true})

nvim_set_keymap('n', '<C-s>', ':write<CR>', {silent=true})
nvim_set_keymap('n', '<C-t>', ':tabnew<CR>', {silent=true})
nvim_set_keymap('v', '<C-t>', '"ty:tabnew<CR>"tP', {silent=true})
nvim_set_keymap('n', 'gv', ':0<CR>VG', {silent=true})

-- ALT MAP
nvim_set_keymap('n', '<A-k>', ':lua ToUpRecursive()<cr>==',   { silent=true, noremap = true })
nvim_set_keymap('n', '<A-j>', ':lua ToDownRecursive()<cr>==', { silent=true, noremap = true })
nvim_set_keymap('n', '<A-g>', ':move 0<CR>==',                { silent=true, noremap = true })
nvim_set_keymap('n', '<A-l>', "m0I\t<esc>`0",                 { silent=true, noremap = true })
nvim_set_keymap('n', '<A-h>', "m0^2dh`0",                     { silent=true, noremap = true })
nvim_set_keymap('n', '<A-n>', "m0yyp`0j",                     { silent=true, noremap = true })
nvim_set_keymap('n', '<A-p>', "m0yyP`0k",                     { silent=true, noremap = true })
nvim_set_keymap('n', '<A-d>', "<Plug>(coc-range-select)",     { silent=true, noremap = true })
nvim_set_keymap('n', '<A-n>', ':move<space>',                 { silent=true, noremap = true })

nvim_set_keymap('v', '<A-k>', ":move -2<cr>gv=gv",  { silent=true, noremap = true })
nvim_set_keymap('v', '<A-j>', ":move'>+<cr>gv=gv",  { silent=true, noremap = true })
nvim_set_keymap('v', '<A-h>', ":normal ^2dh<cr>gv", { silent=true, noremap = true })
nvim_set_keymap('v', '<A-l>', ":normal I <cr>gv",   { silent=true, noremap = true })
nvim_set_keymap('v', '<A-n>', ':move<space>',       { silent=true, noremap = true })
nvim_set_keymap('v', '<A-g>', ':move 0<CR>gb',      { silent=true, noremap = true })


-- Sort
nvim_set_keymap('v', '<leader>s', ':sort<CR>gv=gv', { noremap = true })
nvim_set_keymap('n', '<leader>ss', "m0ggVG:sort<CR>`0==", { noremap = true })
nvim_set_keymap('n', '<leader>sp', "m0vip:sort<CR>`0==", { noremap = true })
nvim_set_keymap('n', '<leader>s{', "m0vi{:sort<CR>`0==", { noremap = true })
nvim_set_keymap('n', '<leader>s[', "m0vi[:sort<CR>`0==", { noremap = true })
nvim_set_keymap('n', '<leader>s(', "m0vi(:sort<CR>`0==", { noremap = true })
nvim_set_keymap('n', "<leader>s'", "m0vi':sort<CR>`0==", { noremap = true })
nvim_set_keymap('n', '<leader>s"', "m0vi\":sort<CR>`0==", { noremap = true })
nvim_set_keymap('n', '<leader>s`', "m0vi`:sort<CR>`0==", { noremap = true })

-- Sort uniq
nvim_set_keymap('v', '<leader>s', ':sort u<CR>gv=gb', { noremap = true })
nvim_set_keymap('n', '<leader>sp', "m0vip:sort u<CR>`0==", { noremap = true })
nvim_set_keymap('n', '<leader>s(', "n0vi(:sort u<CR>`0==", { noremap = true })
nvim_set_keymap('n', '<leader>s[', "n0vi[:sort u<CR>`0==", { noremap = true })
nvim_set_keymap('n', '<leader>ss', "m0ggvg:sort u<CR>`0==", { noremap = true })
nvim_set_keymap('n', '<leader>s{', "n0vi{:sort u<CR>`0==", { noremap = true })
nvim_set_keymap('n', "<leader>S'", "n0vi':sort u<CR>`0==", { noremap = true })
nvim_set_keymap('n', '<leader>S"', "n0vi\":sort u<CR>`0==", { noremap = true })
nvim_set_keymap('n', '<leader>S`', "n0vi`:sort u<CR>`0==", { noremap = true })

-- Reverse
nvim_set_keymap('v', '<leader>r', ':sort!<cr>gv=gv', {noremap = true})
nvim_set_keymap('n', '<leader>rs', 'm0ggVG:sort!<cr>`0==', {noremap = true})
nvim_set_keymap('n', '<leader>rp', 'm0vip:sort!<cr>`0==', {noremap = true})
nvim_set_keymap('n', '<leader>r{', 'n0vi{:sort!<cr>`0==', {noremap = true})
nvim_set_keymap('n', '<leader>r[', 'n0vi[:sort!<cr>`0==', {noremap = true})
nvim_set_keymap('n', '<leader>r(', 'n0vi(:sort!<cr>`0==', {noremap = true})
nvim_set_keymap('n', "<leader>r'", 'n0vi\':sort!<cr>`0==', {noremap = true})
nvim_set_keymap('n', '<leader>r"', 'n0vi":sort!<cr>`0==', {noremap = true})
nvim_set_keymap('n', '<leader>r`', 'n0vi`:sort!<cr>`0==', {noremap = true})

-- Reverse uniq
nvim_set_keymap('v', '<leader>R', ':sort! u<cr>gv=gv', {noremap = true})
nvim_set_keymap('n', '<leader>Rr', 'm0ggVG:sort! u<cr>`0==', {noremap = true})
nvim_set_keymap('n', '<leader>Rp', 'm0vip:sort! u<cr>`0==', {noremap = true})
nvim_set_keymap('n', '<leader>R{', 'n0vi{:sort! u<cr>`0==', {noremap = true})
nvim_set_keymap('n', '<leader>R[', 'n0vi[:sort! u<cr>`0==', {noremap = true})
nvim_set_keymap('n', '<leader>R(', 'n0vi(:sort! u<cr>`0==', {noremap = true})
nvim_set_keymap('n', "<leader>R'", 'n0vi\':sort! u<cr>`0==', {noremap = true})
nvim_set_keymap('n', '<leader>R"', 'n0vi":sort! u<cr>`0==', {noremap = true})
nvim_set_keymap('n', '<leader>R`', 'n0vi`:sort! u<cr>`0==', {noremap = true})

-- CTRL MAP
nvim_set_keymap('v', '<C-/>', ':Commentary<CR>gv=gv', {silent = true, noremap = true })
nvim_set_keymap('n', '<C-/>', ':Commentary<CR>==',    {silent = true})
nvim_set_keymap('i', '<C-/>', '<esc>:Commentary<cr>', {silent = true})

-- TMUX FIX COMMENT
nvim_set_keymap('v', '<C-_>', ':Commentary<CR>gv=gv',  {silent = true, noremap = true })
nvim_set_keymap('n', '<C-_>', ':Commentary<CR>==',     {silent = true})
nvim_set_keymap('i', '<C-_>', '<esc>:Commentary<cr>a', {silent = true})

nvim_set_keymap('n', '<leader>cc', ':Commentary<cr>', {})
nvim_set_keymap('v', '<leader>cc', ':Commentary<cr>gv=gv', {})

nvim_set_keymap('n', '<leader>cp', "m0vip=vip:Commentary<cr>`0", {})
nvim_set_keymap('n', '<leader>c[', "m0vi[=vi[:Commentary<cr>`0", {})
nvim_set_keymap('n', '<leader>c{', "m0vi{=vi{:Commentary<cr>`0", {})
nvim_set_keymap('n', '<leader>c<', "m0vi<=vi<:Commentary<cr>`0", {})
nvim_set_keymap('n', '<leader>c(', "m0vi(=vi(:Commentary<cr>`0", {})
nvim_set_keymap('n', "<leader>c'", "m0vi'=vi':Commentary<cr>`0", {})
nvim_set_keymap('n', '<leader>c"', 'm0vi"=vi":Commentary<cr>`0', {})
nvim_set_keymap('n', '<leader>c`', "m0vi`=vi`:Commentary<cr>`0", {})

nvim_set_keymap('n', '<leader>cap', "m0vap=vap:Commentary<cr>`0", {})
nvim_set_keymap('n', '<leader>ca[', "m0va[=va[:Commentary<cr>`0", {})
nvim_set_keymap('n', '<leader>ca{', "m0va{=va{:Commentary<cr>`0", {})
nvim_set_keymap('n', '<leader>ca<', "m0va<=va<:Commentary<cr>`0", {})
nvim_set_keymap('n', '<leader>ca(', "m0va(=va(:Commentary<cr>`0", {})
nvim_set_keymap('n', "<leader>ca'", "m0va'=va':Commentary<cr>`0", {})
nvim_set_keymap('n', '<leader>ca"', 'm0va"=va":Commentary<cr>`0', {})
nvim_set_keymap('n', '<leader>ca`', "m0va`=va`:Commentary<cr>`0", {})

nvim_set_keymap('n', '<leader>cip', "m0vip=vip:Commentary<cr>`0", { noremap = true, silent = true })
nvim_set_keymap('n', '<leader>ci[', "m0vi[=vi[:Commentary<cr>`0", { noremap = true, silent = true })
nvim_set_keymap('n', '<leader>ci{', "m0vi{=vi{:Commentary<cr>`0", { noremap = true, silent = true })
nvim_set_keymap('n', '<leader>ci<', "m0vi<=vi<:Commentary<cr>`0", { noremap = true, silent = true })
nvim_set_keymap('n', '<leader>ci(', "m0vi(=vi(:Commentary<cr>`0", { noremap = true, silent = true })
nvim_set_keymap('n', "<leader>ci'", "m0vi'=vi':Commentary<cr>`0", { noremap = true, silent = true })
nvim_set_keymap('n', '<leader>ci"', 'm0vi"=vi":Commentary<cr>`0', { noremap = true, silent = true })
nvim_set_keymap('n', '<leader>ci`', 'm0vi`=vi`:Commentary<cr>`0', { noremap = true, silent = true })

-- Format
nvim_set_keymap('v', '=e', '==:EasyAlign<cr><right>', { noremap = true, silent = true })
nvim_set_keymap('v', '=<right>', '=gv:EasyAlign<cr><right>', { noremap = true, silent = true })
nvim_set_keymap('v', '= ', '=gv:EasyAlign<cr>* ', { noremap = true, silent = true })
nvim_set_keymap('v', '=:', '=gv:EasyAlign<cr><right>:', { noremap = true, silent = true })
nvim_set_keymap('v', '=+', '=gv:EasyAlign<cr><right>=', { noremap = true, silent = true })
nvim_set_keymap('v', '=,', '=gv:EasyAlign<cr><right>,', { noremap = true, silent = true })
nvim_set_keymap('v', '=. ', '=gv:EasyAlign<cr><right>.', { noremap = true, silent = true })

nvim_set_keymap('n', '=:', 'vi{=vi{:EasyAlign<cr><right>:', { noremap = true })
nvim_set_keymap('n', '=+', 'vip=vip:EasyAlign<cr><right>=', { noremap = true })
nvim_set_keymap('n', '= ', 'vip=vip:EasyAlign<cr>*<space>', { noremap = true })

nvim_set_keymap('n', '=.', 'm0ggVG=`0', { noremap = true })
nvim_set_keymap('n', '=l', ':CocCommand eslint.executeAutofix<CR>', { noremap = true })
nvim_set_keymap('n', '=p', ':CocCommand prettier.formatFile<CR>', { noremap = true })
nvim_set_keymap('v', '=l', ':CocCommand eslint.executeAutofix<CR>', { noremap = true })
nvim_set_keymap('v', '=p', ':CocCommand prettier.formatFile<CR>', { noremap = true })

-- Delete
nvim_set_keymap('n', 'dp', 'dip', { noremap = true })
nvim_set_keymap('n', 'd.', 'gg0VG$d', { noremap = true })
nvim_set_keymap('n', 'd ', ':StripWhitespace<cr>', { noremap = true })
nvim_set_keymap('n', 'd<cr>', ':g/^\\s*$/d<CR>', { noremap = true })
nvim_set_keymap('n', 'd<tab>', 'm0^d0`0', { noremap = true })
nvim_set_keymap('n', 'do', 'vj:s/^\n//<cr>', { noremap = true })
nvim_set_keymap('n', 'dO', 'V:s/^\n//<cr>', { noremap = true })
nvim_set_keymap('n', 'dy', 'm0<C-v>ggoGx`0', { noremap = true })
nvim_set_keymap('n', 'd#', 'm0"0yiwVgg:s/<C-r>0//g<cr>`0:nog<cr>', { noremap = true })
nvim_set_keymap('n', 'd!', 'm0"0yiw:%s/<C-r>0//<cr>`0:noh<cr>', { noremap = true })
nvim_set_keymap('n', 'd*', 'm0"0yiwVG:s/<C-r>0//g<cr>`0:noh<cr>', { noremap = true })
nvim_set_keymap('n', 'dv', 'gvd', { noremap = true })
nvim_set_keymap('n', 'd/', ':%s/<C-r>///<cr>', { noremap = true })
nvim_set_keymap('n', 'dc', 'm0"0yl:%s/<C-r>0//<cr>', { noremap = true })

nvim_set_keymap('v', 'D<cr>', ':g/^\\s*$/d<CR>gv', {})
nvim_set_keymap('v', 'D<space>', ':StripWhitespace<cr>gv', {})
nvim_set_keymap('v', 'D<tab>', ':normal ^d0<cr>', {})
nvim_set_keymap('v', 'DV', 'm0d:%s/<C-r>"//<cr>`0', {})

-- Fold
nvim_set_keymap('n', 'z*', 'Vggzf', {})
nvim_set_keymap('n', 'z#', 'VGzf', {})
nvim_set_keymap('n', 'z(', 'va(zf', {})
nvim_set_keymap('n', 'z<', 'va<zf', {})
nvim_set_keymap('n', 'z[', 'va[zf', {})
nvim_set_keymap('n', 'z{', 'va{zf', {})
nvim_set_keymap('n', 'z"', 'va"zf', {})
nvim_set_keymap('n', "z'", 'va\'zf', {})
nvim_set_keymap('n', 'z`', 'va`zf', {})
nvim_set_keymap('n', 'zp', 'vipzfzz', {})

-- Visual
nvim_set_keymap('n', 'vp', 'vip', {})
nvim_set_keymap('n', 'v.', ':0<CR>VG', {})
nvim_set_keymap('n', 'v/', 'G$n<C-v>N', {})
nvim_set_keymap('n', 'v!', 'gg<C-v>Gzt', {})
nvim_set_keymap('n', 'v#', 'm0gg<C-v>`0zb', {})
nvim_set_keymap('n', 'v*', 'm0G<C-v>`0zt', {})
nvim_set_keymap('n', 'vv', '0v$', {})

-- Change
nvim_set_keymap('n', 'cp', 'cip', {noremap = true})
nvim_set_keymap('n', 'c.', 'ggVGs', {noremap = true})
nvim_set_keymap('n', 'c#', [["0yiwVgg:s/<C-r>0//cg<left><left><left>]], {noremap = true})
nvim_set_keymap('n', 'c!', [["0yiw:%s/<C-r>0//cg<left><left><left>]], {noremap = true})
nvim_set_keymap('n', 'c*', [["0yiwVG:s/<C-r>0//cg<left><left><left>]], {noremap = true})
nvim_set_keymap('v', 'C', [["0y:%s/<C-r>0//cg<left><left><left>]], {noremap = true})

-- Copy
nvim_set_keymap('n', 'yp', 'yip', {noremap = true})
nvim_set_keymap('n', 'yd', ':let @+ = expand("%")<cr>', {noremap = true})
nvim_set_keymap('n', 'y.', 'm0ggVGy`0', {noremap = true})

-- Other
nvim_set_keymap('n', '<Home>', ':1<CR>', {noremap = true})
nvim_set_keymap('n', '<End>', ':$<CR>', {noremap = true})
nvim_set_keymap('x', '<Home>', ':1<CR>', {noremap = true})
nvim_set_keymap('x', '<End>', ':$<CR>', {noremap = true})

nvim_set_keymap('n', '<C-space>', ':call CocActionAsync("doHover")<CR>', {})
nvim_set_keymap('n', '<leader>vn', ':lua CheckboxRelative()<cr>', {silent = true})
nvim_set_keymap('n', '<leader>vc', ':lua CheckboxSpaceHighlight()<cr>', {silent = true})
nvim_set_keymap('x', '<leader>/', '"hy/<C-r>h<CR>', {silent = true})
nvim_set_keymap('x', '<leader>?', '"hy?<C-r>h<CR>', {silent = true})

vim.keymap.set("i", "<C-Space>", "coc#pum#visible() ? coc#pum#stop() : coc#refresh()", { expr = true, noremap = true, silent = true })
vim.keymap.set("i", "<Tab>", "coc#pum#visible() ? coc#pum#next(1) : '<Tab>'", { expr = true, noremap = true, silent = true })
vim.keymap.set("i", "<S-Tab>", "coc#pum#visible() ? coc#pum#prev(1) : '<C-h>'", { expr = true, noremap = true, silent = true })
vim.keymap.set("i", "<CR>", "coc#pum#visible() ? coc#pum#confirm() : '<C-g>u<CR>'", { expr = true, noremap = true, silent = true })

vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true })
vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
