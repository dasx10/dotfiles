nvim_set_keymap = vim.api.nvim_set_keymap;
-- PLEADER MAP
vim.g.mapleader = " "

local s = { silent = true }
local sn = { silent = true, noremap = true }
local snx = { silent = true, noremap = true, expr = true }
local n = { noremap = true }
local e = {}
local x = { expr = true }

local L = function(length)
  return string.rep("<left>", length)
end

nvim_set_keymap('n', 'j', "(v:count == 0 ? 'gj' : 'j')", snx)
nvim_set_keymap('n', ')', "(v:count == 0 ? 'g' : '')", snx)

nvim_set_keymap('n', 'Zq', ':q<CR>', sn)
nvim_set_keymap('n', '<S-tab>', '<Plug>(coc-diagnostic-prev)', sn)
nvim_set_keymap('n', '<tab>', '<Plug>(coc-diagnostic-next)', sn)
nvim_set_keymap('n', '<F2>', '<Plug>(coc-rename)', sn)

-- Create mappings for function text object, requires document symbols feature of languageserver.
nvim_set_keymap('x', 'if', '<Plug>(coc-funcobj-i)', n)
nvim_set_keymap('o', 'if', '<Plug>(coc-funcobj-i)', n)
nvim_set_keymap('x', 'af', '<Plug>(coc-funcobj-a)', n)
nvim_set_keymap('o', 'af', '<Plug>(coc-funcobj-a)', n)

-- Mouse map
nvim_set_keymap('n', '<C-LeftMouse>', '<Plug>(VM-Mouse-Cursor)', sn)
nvim_set_keymap('n', '<A-RightMouse>', '<Plug>(VM-Mouse-Word)', sn)
nvim_set_keymap('n', '<M-C-RightMouse>', '<Plug>(VM-Mouse-Column)', sn)

nvim_set_keymap('n', '<leader><cr>', ':.!zsh<cr>', n)
-- CoC
nvim_set_keymap('x', '<leader>ss', '<Plug>(coc-convert-snippet)', n)
nvim_set_keymap('x', '<leader>cf', '<Plug>(coc-format-selected)', n)
nvim_set_keymap('n', '<leader>cf', '<Plug>(coc-format-selected)', n)
nvim_set_keymap('x', '<leader><tab>', '<Plug>(coc-codeaction-selected)<cr>', n)
nvim_set_keymap('n', '<leader><tab>', '<Plug>(coc-codeaction)', n)
nvim_set_keymap('n', '=x', '<Plug>(coc-fix-current)', n)
nvim_set_keymap('n', '<leader>fd', ':<C-u>CocList diagnostics<cr>', sn)
nvim_set_keymap('n', '<leader>fo', ':<C-u>CocList outline<cr>', sn)
nvim_set_keymap('n', '<leader>fs', ':<C-u>CocList -I symbols<cr>', sn)
nvim_set_keymap('n', '<leader>cr', ':<C-u>CocListResume<CR>', sn)
nvim_set_keymap('n', '<leader><space>', ':<C-u>CocList commands<cr>', sn)
nvim_set_keymap('n', '<leader>q', ':bufdo bd<cr>', e)

nvim_set_keymap('n', '<leader>g',        ':Git<space>', e)
nvim_set_keymap('n', '<leader>g<space>', ':Git blame<cr>', e)
nvim_set_keymap('n', '<leader>gA',       ':!git add -A<CR>', s)
nvim_set_keymap('n', '<leader>ga',       ':Git add<space>', s)
nvim_set_keymap('n', '<leader>gP',       ':Git pull<space>', e)
nvim_set_keymap('n', '<leader>gPo',      ':Git pull origin<space>', e)
nvim_set_keymap('n', '<leader>gPP',      ':!git pull origin $(git branch --show-current)<cr>', e)
nvim_set_keymap('n', '<leader>gmm',      ':!(git fecth && git pull origin $(git branch --show-current) && git merge origin $(git branch --show-current)) & <cr>', e)
nvim_set_keymap('n', '<leader>gp',       ':Git push<space>', e)
nvim_set_keymap('n', '<leader>gpo',      ':Git push origin<space>', e)
nvim_set_keymap('n', '<leader>gpp',      ':!git push origin $(git branch --show-current) &<cr>', e)
nvim_set_keymap(
  'n',
  '<leader>gC',
  ':!git commit -am "" && git push origin $(git branch --show-current)' .. L(49),
  e
)
nvim_set_keymap(
  'n',
  '<leader>w',
  ':w<cr>:!git commit --amend -am ""' .. L(1),
  e
)
nvim_set_keymap(
  'n',
  '<leader>W',
  ':w<cr>:!git commit --amend -am "" && git push origin $(git branch --show-current)' .. L(49),
  e
)
nvim_set_keymap('n', '<leader>ga%', ':Git add %<CR>', e)
nvim_set_keymap('n', '<leader>ga',  ':Git add<space>', e)
nvim_set_keymap('n', '<leader>gb',  ':Git branch<space>', e)
nvim_set_keymap('n', '<leader>gc',  ':Git commit<space>', e)
nvim_set_keymap('n', '<leader>gam', ':Git commit -am<space>""<left>', e)
nvim_set_keymap('n', '<leader>gcm', ':Git commit -m ""<left>', e)
nvim_set_keymap('n', '<leader>gcM', ':Git commit --amend -m ""' .. L(1), e)
nvim_set_keymap('n', '<leader>gd',  ':Git diff<CR>', s)
nvim_set_keymap('n', '<leader>gdh', ':Gdiffsplit<CR>', s)
nvim_set_keymap('n', '<leader>gds', ':Gvdiffsplit<CR>', s)
nvim_set_keymap('n', '<leader>gdv', ':Gdiffsplit<CR>', s)
nvim_set_keymap('n', '<leader>gf',  ':!git fetch &<CR>', e)
nvim_set_keymap('n', '<leader>gg',  ':Git<CR>', s)
nvim_set_keymap('n', '<leader>ghp', '<Plug>(GitGutterPreviewHun)', e)
nvim_set_keymap('n', '<leader>ghs', '<Plug>(GitGutterStageHun)', e)
nvim_set_keymap('n', '<leader>ghu', '<Plug>(GitGutterUndoHun)', e)
nvim_set_keymap('n', '<leader>gl',  ':Git log<CR>', s)
nvim_set_keymap('n', '<leader>gm',  ':Git merge<space>', e)
nvim_set_keymap('n', '<leader>gmo', ':Git merge origin<space>', e)
nvim_set_keymap('n', '<leader>gn',  ':Git checkout -b<space>', e)
nvim_set_keymap('n', '<leader>go',  ':Git checkout<space>', e)
nvim_set_keymap('n', '<leader>gr',  ':Git rebase<space>', e)
nvim_set_keymap('n', '<leader>gro', ':Git push origin :<left>', e)
nvim_set_keymap('n', '<leader>gs',  ':!git status<CR>', e)
nvim_set_keymap('n', '<leader>gw',  ':Git switch<space>', e)
nvim_set_keymap('n', '<leader>gz',  ':LazyGit<cr>', e)
-- https://github.com/enclaive/emcp_be/compare/staging...yk/state_fix?expand=1

-- Searching
nvim_set_keymap('n', '<leader>od', '<Plug>(coc-definition)', s)
nvim_set_keymap('n', '<leader>ot', '<Plug>(coc-type-definition)', s)
nvim_set_keymap('n', '<leader>oi', '<Plug>(coc-implementation)', s)
nvim_set_keymap('n', '<leader>or', '<Plug>(coc-references)', s)
nvim_set_keymap('n', '<leader>oc', ':copen<CR>', s)
nvim_set_keymap('n', '<leader>og', ':registers<CR>', s)
nvim_set_keymap('n', '<leader>/', ':nohlsearch<CR>', s)

nvim_set_keymap('n', '<leader>rn', '/[0-9]\\+<CR>', s)
nvim_set_keymap('n', '<leader>rw', '/[a-zA-Z]\\+<CR>', s)
nvim_set_keymap('n', '<leader>rc', '/[A-Z][a-z]\\+<CR>', s)
nvim_set_keymap('n', '<leader>ru', '/[A-Z]\\+<CR>', s)
nvim_set_keymap('n', '<leader>rl', '/[a-z]\\+<CR>', s)

nvim_set_keymap('n', '<leader>fot', '/<[a-z]\\+ [a-z=\'"]\\+ [a-z\'"]\\+<cr>', s)

nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<cr>', s)
nvim_set_keymap('n', '<leader>fw', ':Telescope live_grep<cr>', s)
nvim_set_keymap('n', '<leader>fh', ':Telescope help_tags<cr>', s)
nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<cr>', s)
nvim_set_keymap('n', "<leader>f'", ':Telescope marks<cr>', s)
nvim_set_keymap('n', '<leader>fgb', ':Telescope git_branches<cr>', s)
nvim_set_keymap('n', '<leader>fgc', ':Telescope git_commits<cr>', s)


nvim_set_keymap('n', '<leader>t', ':Vifm <cr>', s)

-- Formating
nvim_set_keymap('x', '<leader>fe', ':!node ~/.config/nvim/scripts/ru2en.js<CR>', s)
nvim_set_keymap('n', '<leader>fc', 'V:!node ~/.config/nvim/scripts/toCamel.js<CR>', s)
nvim_set_keymap('x', '<leader>fc', ':!node ~/.config/nvim/scripts/toCamel.js<CR>', s)
nvim_set_keymap('x', '<leader>fm', ':!node ~/.config/nvim/scripts/calc.js<CR>', s)
nvim_set_keymap('n', '<leader>fm', 'V:!node ~/.config/nvim/scripts/calc.js<CR>', s)

nvim_set_keymap('n', '<C-s>', ':write<CR>', s)
nvim_set_keymap('n', '<C-t>', ':tabnew<CR>', s)
nvim_set_keymap('v', '<C-t>', '"ty:tabnew<CR>"tP', s)
nvim_set_keymap('n', 'gv', ':0<CR>VG', s)

-- ALT MAP
nvim_set_keymap('n', '<A-k>', ':lua ToUpRecursive()<cr>==',   sn)
nvim_set_keymap('n', '<A-j>', ':lua ToDownRecursive()<cr>==', sn)
nvim_set_keymap('n', '<A-g>', ':move 0<CR>==',                sn)
nvim_set_keymap('n', '<A-l>', "m0I\t<esc>`0",                 sn)
nvim_set_keymap('n', '<A-S-l>', "m0I\t\t<esc>`0",                 sn)
nvim_set_keymap('n', '<A-h>', "m0^2dh`0",                     sn)
nvim_set_keymap('n', '<A-n>', "m0yyp`0j",                     sn)
nvim_set_keymap('n', '<A-p>', "m0yyP`0k",                     sn)
nvim_set_keymap('n', '<A-d>', "<Plug>(coc-range-select)",     sn)
nvim_set_keymap('n', '<A-n>', ':move<space>',                 sn)

nvim_set_keymap('v', '<A-k>', ":move -2<cr>gv=gv",  sn)
nvim_set_keymap('v', '<A-j>', ":move'>+<cr>gv=gv",  sn)
nvim_set_keymap('v', '<A-h>', ":normal ^2dh<cr>gv", sn)
nvim_set_keymap('v', '<A-l>', ":normal I <cr>gv",   sn)
nvim_set_keymap('v', '<A-n>', ':move<space>',       sn)
nvim_set_keymap('v', '<A-g>', ':move 0<CR>gb',      sn)

-- Sort
nvim_set_keymap('v', '<leader>s', ':sort<CR>gv=gv', n)
nvim_set_keymap('n', '<leader>ss', "m0ggVG:sort<CR>`0==", n)
nvim_set_keymap('n', '<leader>sp', "m0vip:sort<CR>`0==", n)
nvim_set_keymap('n', '<leader>s{', "m0vi{:sort<CR>`0==", n)
nvim_set_keymap('n', '<leader>s[', "m0vi[:sort<CR>`0==", n)
nvim_set_keymap('n', '<leader>s(', "m0vi(:sort<CR>`0==", n)
nvim_set_keymap('n', "<leader>s'", "m0vi':sort<CR>`0==", n)
nvim_set_keymap('n', '<leader>s"', "m0vi\":sort<CR>`0==", n)
nvim_set_keymap('n', '<leader>s`', "m0vi`:sort<CR>`0==", n)

-- Sort uniq
nvim_set_keymap('v', '<leader>s', ':sort u<CR>gv=gb', n)
nvim_set_keymap('n', '<leader>sp', "m0vip:sort u<CR>`0==", n)
nvim_set_keymap('n', '<leader>s(', "n0vi(:sort u<CR>`0==", n)
nvim_set_keymap('n', '<leader>s[', "n0vi[:sort u<CR>`0==", n)
nvim_set_keymap('n', '<leader>ss', "m0ggvg:sort u<CR>`0==", n)
nvim_set_keymap('n', '<leader>s{', "n0vi{:sort u<CR>`0==", n)
nvim_set_keymap('n', "<leader>S'", "n0vi':sort u<CR>`0==", n)
nvim_set_keymap('n', '<leader>S"', "n0vi\":sort u<CR>`0==", n)
nvim_set_keymap('n', '<leader>S`', "n0vi`:sort u<CR>`0==", n)

-- Reverse
nvim_set_keymap('v', '<leader>r', ':sort!<cr>gv=gv', n)
nvim_set_keymap('n', '<leader>rs', 'm0ggVG:sort!<cr>`0==', n)
nvim_set_keymap('n', '<leader>rp', 'm0vip:sort!<cr>`0==', n)
nvim_set_keymap('n', '<leader>r{', 'n0vi{:sort!<cr>`0==', n)
nvim_set_keymap('n', '<leader>r[', 'n0vi[:sort!<cr>`0==', n)
nvim_set_keymap('n', '<leader>r(', 'n0vi(:sort!<cr>`0==', n)
nvim_set_keymap('n', "<leader>r'", 'n0vi\':sort!<cr>`0==', n)
nvim_set_keymap('n', '<leader>r"', 'n0vi":sort!<cr>`0==', n)
nvim_set_keymap('n', '<leader>r`', 'n0vi`:sort!<cr>`0==', n)

-- Reverse uniq
nvim_set_keymap('v', '<leader>R', ':sort! u<cr>gv=gv', n)
nvim_set_keymap('n', '<leader>Rr', 'm0ggVG:sort! u<cr>`0==', n)
nvim_set_keymap('n', '<leader>Rp', 'm0vip:sort! u<cr>`0==', n)
nvim_set_keymap('n', '<leader>R{', 'n0vi{:sort! u<cr>`0==', n)
nvim_set_keymap('n', '<leader>R[', 'n0vi[:sort! u<cr>`0==', n)
nvim_set_keymap('n', '<leader>R(', 'n0vi(:sort! u<cr>`0==', n)
nvim_set_keymap('n', "<leader>R'", 'n0vi\':sort! u<cr>`0==', n)
nvim_set_keymap('n', '<leader>R"', 'n0vi":sort! u<cr>`0==', n)
nvim_set_keymap('n', '<leader>R`', 'n0vi`:sort! u<cr>`0==', n)

-- CTRL MAP
nvim_set_keymap('v', '<C-/>', ':Commentary<CR>gv=gv', sn)
nvim_set_keymap('n', '<C-/>', ':Commentary<CR>==',    s)
nvim_set_keymap('i', '<C-/>', '<esc>:Commentary<cr>', s)

-- TMUX FIX COMMENT
nvim_set_keymap('v', '<C-_>', ':Commentary<CR>gv=gv',  sn)
nvim_set_keymap('n', '<C-_>', ':Commentary<CR>==',     s)
nvim_set_keymap('i', '<C-_>', '<esc>:Commentary<cr>a', s)

nvim_set_keymap('n', '<leader>cc', ':Commentary<cr>', e)
nvim_set_keymap('v', '<leader>cc', ':Commentary<cr>gv=gv', e)

nvim_set_keymap('n', '<leader>cp', "m0vip=vip:Commentary<cr>`0", e)
nvim_set_keymap('n', '<leader>c[', "m0vi[=vi[:Commentary<cr>`0", e)
nvim_set_keymap('n', '<leader>c{', "m0vi{=vi{:Commentary<cr>`0", e)
nvim_set_keymap('n', '<leader>c<', "m0vi<=vi<:Commentary<cr>`0", e)
nvim_set_keymap('n', '<leader>c(', "m0vi(=vi(:Commentary<cr>`0", e)
nvim_set_keymap('n', "<leader>c'", "m0vi'=vi':Commentary<cr>`0", e)
nvim_set_keymap('n', '<leader>c"', 'm0vi"=vi":Commentary<cr>`0', e)
nvim_set_keymap('n', '<leader>c`', "m0vi`=vi`:Commentary<cr>`0", e)

nvim_set_keymap('n', '<leader>cap', "m0vap=vap:Commentary<cr>`0", e)
nvim_set_keymap('n', '<leader>ca[', "m0va[=va[:Commentary<cr>`0", e)
nvim_set_keymap('n', '<leader>ca{', "m0va{=va{:Commentary<cr>`0", e)
nvim_set_keymap('n', '<leader>ca<', "m0va<=va<:Commentary<cr>`0", e)
nvim_set_keymap('n', '<leader>ca(', "m0va(=va(:Commentary<cr>`0", e)
nvim_set_keymap('n', "<leader>ca'", "m0va'=va':Commentary<cr>`0", e)
nvim_set_keymap('n', '<leader>ca"', 'm0va"=va":Commentary<cr>`0', e)
nvim_set_keymap('n', '<leader>ca`', "m0va`=va`:Commentary<cr>`0", e)

nvim_set_keymap('n', '<leader>cip', "m0vip=vip:Commentary<cr>`0", sn)
nvim_set_keymap('n', '<leader>ci[', "m0vi[=vi[:Commentary<cr>`0", sn)
nvim_set_keymap('n', '<leader>ci{', "m0vi{=vi{:Commentary<cr>`0", sn)
nvim_set_keymap('n', '<leader>ci<', "m0vi<=vi<:Commentary<cr>`0", sn)
nvim_set_keymap('n', '<leader>ci(', "m0vi(=vi(:Commentary<cr>`0", sn)
nvim_set_keymap('n', "<leader>ci'", "m0vi'=vi':Commentary<cr>`0", sn)
nvim_set_keymap('n', '<leader>ci"', 'm0vi"=vi":Commentary<cr>`0', sn)
nvim_set_keymap('n', '<leader>ci`', 'm0vi`=vi`:Commentary<cr>`0', sn)

-- Format
nvim_set_keymap('v', '=e', '==:EasyAlign<cr><right>', sn)
nvim_set_keymap('v', '=<right>', '=gv:EasyAlign<cr><right>', sn)
nvim_set_keymap('v', '= ', '=gv:EasyAlign<cr>* ', sn)
nvim_set_keymap('v', '=:', '=gv:EasyAlign<cr><right>:', sn)
nvim_set_keymap('v', '=+', '=gv:EasyAlign<cr><right>=', sn)
nvim_set_keymap('v', '=,', '=gv:EasyAlign<cr><right>,', sn)
nvim_set_keymap('v', '=. ', '=gv:EasyAlign<cr><right>.', sn)

nvim_set_keymap('n', '=:', 'vi{=vi{:EasyAlign<cr><right>:', n)
nvim_set_keymap('n', '=+', 'vip=vip:EasyAlign<cr><right>=', n)
nvim_set_keymap('n', '= ', 'vip=vip:EasyAlign<cr>*<space>', n)

nvim_set_keymap('n', '=l', ':CocCommand eslint.executeAutofix<CR>', n)
nvim_set_keymap('n', '=p', ':CocCommand prettier.formatFile<CR>', n)
nvim_set_keymap('v', '=l', ':CocCommand eslint.executeAutofix<CR>', n)
nvim_set_keymap('v', '=p', ':CocCommand prettier.formatFile<CR>', n)
nvim_set_keymap('n', '=L', ':!npx eslint --fix %<cr>', n)
nvim_set_keymap('n', '=.', 'm0ggVG=`0', n)

-- Delete
nvim_set_keymap('n', 'dp', 'dip', n)
nvim_set_keymap('n', 'd.', 'gg0VG$d', n)
nvim_set_keymap('n', 'd ', ':StripWhitespace<cr>', n)
nvim_set_keymap('n', 'd<cr>', ':g/^\\s*$/d<CR>', n)
nvim_set_keymap('n', 'd<tab>', 'm0^d0`0', n)
nvim_set_keymap('n', 'do', 'vj:s/^\n//<cr>', n)
nvim_set_keymap('n', 'dO', 'V:s/^\n//<cr>', n)
nvim_set_keymap('n', 'dy', 'm0<C-v>ggoGx`0', n)
nvim_set_keymap('n', 'd#', 'm0"0yiwVgg:s/<C-r>0//g<cr>`0:nog<cr>', n)
nvim_set_keymap('n', 'd!', 'm0"0yiw:%s/<C-r>0//<cr>`0:noh<cr>', n)
nvim_set_keymap('n', 'd*', 'm0"0yiwVG:s/<C-r>0//g<cr>`0:noh<cr>', n)
nvim_set_keymap('n', 'dv', 'gvd', n)
nvim_set_keymap('n', 'd/', ':%s/<C-r>///<cr>', n)
nvim_set_keymap('n', 'dc', 'm0"0yl:%s/<C-r>0//<cr>', n)

nvim_set_keymap('v', 'D<cr>', ':g/^\\s*$/d<CR>gv', e)
nvim_set_keymap('v', 'D<space>', ':StripWhitespace<cr>gv', e)
nvim_set_keymap('v', 'D<tab>', ':normal ^d0<cr>', e)
nvim_set_keymap('v', 'DV', 'm0d:%s/<C-r>"//<cr>`0', e)
-- Fold
nvim_set_keymap('n', 'z*', 'Vggzf', e)
nvim_set_keymap('n', 'z#', 'VGzf', e)
nvim_set_keymap('n', 'z(', 'va(zf', e)
nvim_set_keymap('n', 'z<', 'va<zf', e)
nvim_set_keymap('n', 'z[', 'va[zf', e)
nvim_set_keymap('n', 'z{', 'va{zf', e)
nvim_set_keymap('n', 'z"', 'va"zf', e)
nvim_set_keymap('n', "z'", 'va\'zf', e)
nvim_set_keymap('n', 'z`', 'va`zf', e)
nvim_set_keymap('n', 'zp', 'vipzfzz', e)
-- Visual
nvim_set_keymap('n', 'vp', 'vip', e)
nvim_set_keymap('n', 'v.', ':0<CR>VG', e)
nvim_set_keymap('n', 'v/', 'G$n<C-v>N', e)
nvim_set_keymap('n', 'v!', 'gg<C-v>Gzt', e)
nvim_set_keymap('n', 'v#', 'm0gg<C-v>`0zb', e)
nvim_set_keymap('n', 'v*', 'm0G<C-v>`0zt', e)
nvim_set_keymap('n', 'vv', '0v$', e)
-- Change
nvim_set_keymap('n', 'cp', 'cip', n)
nvim_set_keymap('n', 'c.', 'ggVGs', n)
nvim_set_keymap('n', 'c#', [["0yiwVgg:s/<C-r>0//cg<left><left><left>]], n)
nvim_set_keymap('n', 'c!', [["0yiw:%s/<C-r>0//cg<left><left><left>]], n)
nvim_set_keymap('n', 'c*', [["0yiwVG:s/<C-r>0//cg<left><left><left>]], n)
nvim_set_keymap('v', 'C', [["0y:%s/<C-r>0//cg<left><left><left>]], n)
-- Copy
nvim_set_keymap('n', 'yp', 'yip', n)
nvim_set_keymap('n', 'yd', ':let @+ = expand("%")<cr>', n)
nvim_set_keymap('n', 'y.', 'm0ggVGy`0', n)

-- Other
nvim_set_keymap('n', '<Home>', ':1<CR>', n)
nvim_set_keymap('n', '<End>', ':$<CR>', n)
nvim_set_keymap('x', '<Home>', ':1<CR>', n)
nvim_set_keymap('x', '<End>', ':$<CR>', n)

nvim_set_keymap('n', '<C-space>', ':call CocActionAsync("doHover")<CR>', e)
nvim_set_keymap('n', '<leader>vn', ':lua CheckboxRelative()<cr>', s)
nvim_set_keymap('n', '<leader>vc', ':lua CheckboxSpaceHighlight()<cr>', s)
nvim_set_keymap('x', '<leader>/', '"hy/<C-r>h<CR>', s)
nvim_set_keymap('x', '<leader>?', '"hy?<C-r>h<CR>', s)

vim.keymap.set("i", "<C-Space>", "coc#pum#visible() ? coc#pum#stop() : coc#refresh()", snx)
vim.keymap.set("i", "<Tab>", "coc#pum#visible() ? coc#pum#next(1) : '<Tab>'", snx)
vim.keymap.set("i", "<S-Tab>", "coc#pum#visible() ? coc#pum#prev(1) : '<C-h>'", snx)
vim.keymap.set("i", "<CR>", "coc#pum#visible() ? coc#pum#confirm() : '<C-g>u<CR>'", snx)

vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, x)
vim.keymap.set('i', '<a-,>', function() return vim.fn['codeium#CycleCompletions'](1) end, x)
vim.keymap.set('i', '<a-.>', function() return vim.fn['codeium#CycleCompletions'](-1) end, x)
vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, x)

nvim_set_keymap('i', '<A-n>', '<esc>', sn)
nvim_set_keymap('x', '<A-n>', '<esc>', sn)

nvim_set_keymap('n', '<leader>oh', ":CodeiumChat<cr>", sn)
