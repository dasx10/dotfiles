vim.keymap.set("n", "gl", function()
  vim.diagnostic.open_float()
end, { desc = "Open Diagnostics in Float" })

vim.keymap.set("n", "<leader>cf", function()
  require("conform").format({
    lsp_format = "fallback",
  })
end, { desc = "Format current file" })

-- Map <leader>fp to open projects
vim.keymap.set("n", "<leader>fp", ":ProjectFzf<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-space>", vim.lsp.buf.hover, { silent = true, noremap = true })

nvim_set_keymap = vim.api.nvim_set_keymap
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

nvim_set_keymap("n", "j", "(v:count == 0 ? 'gj' : 'j')", snx)
nvim_set_keymap("n", ")", "(v:count == 0 ? 'g' : '')", snx)

nvim_set_keymap("n", "Zq", ":q<CR>", sn)

-- Create mappings for function text object, requires document symbols feature of languageserver.
-- Mouse map
nvim_set_keymap("n", "<C-LeftMouse>", "<Plug>(VM-Mouse-Cursor)", sn)
nvim_set_keymap("n", "<A-RightMouse>", "<Plug>(VM-Mouse-Word)", sn)
nvim_set_keymap("n", "<M-C-RightMouse>", "<Plug>(VM-Mouse-Column)", sn)

nvim_set_keymap("n", "<leader><cr>", ":.!zsh<cr>", n)
-- CoC
nvim_set_keymap("n", "<leader>q", ":bufdo bd<cr>", e)

nvim_set_keymap("n", "Zh", ":vs<cr>", e)
nvim_set_keymap("n", "Zl", ":vs<cr><C-w>l", e)
nvim_set_keymap("n", "Zk", ":sp<cr>", e)
nvim_set_keymap("n", "Zj", ":sp<cr><C-w>j", e)

-- https://github.com/enclaive/emcp_be/compare/staging...yk/state_fix?expand=1

-- Searching
nvim_set_keymap("n", "<leader>of", '"0yiw/import.\\+<C-R>0.\\+from<CR>/from<cr>/\'\\|"<cr>wgf:noh<cr>/<C-R>0<cr>', s)
nvim_set_keymap("n", "<leader>oc", ":copen<CR>", s)
nvim_set_keymap("n", "<leader>og", ":registers<CR>", s)
nvim_set_keymap("n", "<leader>ow", '"0yiw', s)
nvim_set_keymap("n", "<leader>/", ":nohlsearch<CR>", s)

nvim_set_keymap("n", "<leader>rn", "/[0-9]\\+<CR>", s)
nvim_set_keymap("n", "<leader>rw", "/[a-zA-Z]\\+<CR>", s)
nvim_set_keymap("n", "<leader>rc", "/[A-Z][a-z]\\+<CR>", s)
nvim_set_keymap("n", "<leader>ru", "/[A-Z]\\+<CR>", s)
nvim_set_keymap("n", "<leader>rl", "/[a-z]\\+<CR>", s)

nvim_set_keymap("n", "<leader>fot", "/<[a-z]\\+ [a-z='\"]\\+ [a-z'\"]\\+<cr>", s)

nvim_set_keymap("n", "<leader>t", ":Vifm <cr>", s)

-- Formating
nvim_set_keymap("x", "<leader>fe", ":!node ~/.config/nvim/scripts/ru2en.js<CR>", s)
nvim_set_keymap("n", "<leader>fc", "V:!node ~/.config/nvim/scripts/toCamel.js<CR>", s)
nvim_set_keymap("x", "<leader>fc", ":!node ~/.config/nvim/scripts/toCamel.js<CR>", s)
nvim_set_keymap("x", "<leader>fm", ":!node ~/.config/nvim/scripts/calc.js<CR>", s)
nvim_set_keymap("n", "<leader>fm", "V:!node ~/.config/nvim/scripts/calc.js<CR>", s)

nvim_set_keymap("n", "<C-s>", ":write<CR>", s)
nvim_set_keymap("v", "<C-s>", ":write<CR>", s)
nvim_set_keymap("n", "<C-t>", ":tabnew<CR>", s)
nvim_set_keymap("v", "<C-t>", '"ty:tabnew<CR>"tP', s)

-- Sort
nvim_set_keymap("v", "<leader>s", ":sort<CR>gv=gv", n)
nvim_set_keymap("n", "<leader>ss", "m0ggVG:sort<CR>`0==", n)
nvim_set_keymap("n", "<leader>sp", "m0vip:sort<CR>`0==", n)
nvim_set_keymap("n", "<leader>s{", "m0vi{:sort<CR>`0==", n)
nvim_set_keymap("n", "<leader>s[", "m0vi[:sort<CR>`0==", n)
nvim_set_keymap("n", "<leader>s(", "m0vi(:sort<CR>`0==", n)
nvim_set_keymap("n", "<leader>s'", "m0vi':sort<CR>`0==", n)
nvim_set_keymap("n", '<leader>s"', 'm0vi":sort<CR>`0==', n)
nvim_set_keymap("n", "<leader>s`", "m0vi`:sort<CR>`0==", n)

-- Sort uniq
nvim_set_keymap("v", "<leader>s", ":sort u<CR>gv=gb", n)
nvim_set_keymap("n", "<leader>sp", "m0vip:sort u<CR>`0==", n)
nvim_set_keymap("n", "<leader>s(", "n0vi(:sort u<CR>`0==", n)
nvim_set_keymap("n", "<leader>s[", "n0vi[:sort u<CR>`0==", n)
nvim_set_keymap("n", "<leader>ss", "m0ggvg:sort u<CR>`0==", n)
nvim_set_keymap("n", "<leader>s{", "n0vi{:sort u<CR>`0==", n)
nvim_set_keymap("n", "<leader>S'", "n0vi':sort u<CR>`0==", n)
nvim_set_keymap("n", '<leader>S"', 'n0vi":sort u<CR>`0==', n)
nvim_set_keymap("n", "<leader>S`", "n0vi`:sort u<CR>`0==", n)

-- Reverse
nvim_set_keymap("v", "<leader>r", ":sort!<cr>gv=gv", n)
nvim_set_keymap("n", "<leader>rs", "m0ggVG:sort!<cr>`0==", n)
nvim_set_keymap("n", "<leader>rp", "m0vip:sort!<cr>`0==", n)
nvim_set_keymap("n", "<leader>r{", "n0vi{:sort!<cr>`0==", n)
nvim_set_keymap("n", "<leader>r[", "n0vi[:sort!<cr>`0==", n)
nvim_set_keymap("n", "<leader>r(", "n0vi(:sort!<cr>`0==", n)
nvim_set_keymap("n", "<leader>r'", "n0vi':sort!<cr>`0==", n)
nvim_set_keymap("n", '<leader>r"', 'n0vi":sort!<cr>`0==', n)
nvim_set_keymap("n", "<leader>r`", "n0vi`:sort!<cr>`0==", n)

-- Reverse uniq
nvim_set_keymap("v", "<leader>R", ":sort! u<cr>gv=gv", n)
nvim_set_keymap("n", "<leader>Rr", "m0ggVG:sort! u<cr>`0==", n)
nvim_set_keymap("n", "<leader>Rp", "m0vip:sort! u<cr>`0==", n)
nvim_set_keymap("n", "<leader>R{", "n0vi{:sort! u<cr>`0==", n)
nvim_set_keymap("n", "<leader>R[", "n0vi[:sort! u<cr>`0==", n)
nvim_set_keymap("n", "<leader>R(", "n0vi(:sort! u<cr>`0==", n)
nvim_set_keymap("n", "<leader>R'", "n0vi':sort! u<cr>`0==", n)
nvim_set_keymap("n", '<leader>R"', 'n0vi":sort! u<cr>`0==', n)
nvim_set_keymap("n", "<leader>R`", "n0vi`:sort! u<cr>`0==", n)

-- CTRL MAP
-- Format

nvim_set_keymap("n", "=.", "m0ggVG=`0", n)

-- Delete
nvim_set_keymap("n", "dp", "dip", n)
nvim_set_keymap("n", "d.", "gg0VG$d", n)
nvim_set_keymap("n", "d<cr>", ":g/^\\s*$/d<CR>", n)
nvim_set_keymap("n", "d<tab>", "m0^d0`0", n)
nvim_set_keymap("n", "do", "vj:s/^\n//<cr>", n)
nvim_set_keymap("n", "dO", "V:s/^\n//<cr>", n)
nvim_set_keymap("n", "dy", "m0<C-v>ggoGx`0", n)
nvim_set_keymap("n", "d#", 'm0"0yiwVgg:s/<C-r>0//g<cr>`0:nog<cr>', n)
nvim_set_keymap("n", "d!", 'm0"0yiw:%s/<C-r>0//<cr>`0:noh<cr>', n)
nvim_set_keymap("n", "d*", 'm0"0yiwVG:s/<C-r>0//g<cr>`0:noh<cr>', n)
nvim_set_keymap("n", "dv", "gvd", n)
nvim_set_keymap("n", "d/", ":%s/<C-r>///<cr>", n)
nvim_set_keymap("n", "dc", 'm0"0yl:%s/<C-r>0//<cr>', n)

nvim_set_keymap("v", "D<cr>", ":g/^\\s*$/d<CR>gv", e)
nvim_set_keymap("v", "D<space>", ":StripWhitespace<cr>gv", e)
nvim_set_keymap("v", "D<tab>", ":normal ^d0<cr>", e)
nvim_set_keymap("v", "DV", 'm0d:%s/<C-r>"//<cr>`0', e)
-- Fold
nvim_set_keymap("n", "z*", "Vggzf", e)
nvim_set_keymap("n", "z#", "VGzf", e)
nvim_set_keymap("n", "z(", "va(zf", e)
nvim_set_keymap("n", "z<", "va<zf", e)
nvim_set_keymap("n", "z[", "va[zf", e)
nvim_set_keymap("n", "z{", "va{zf", e)
nvim_set_keymap("n", 'z"', 'va"zf', e)
nvim_set_keymap("n", "z'", "va'zf", e)
nvim_set_keymap("n", "z`", "va`zf", e)
nvim_set_keymap("n", "zp", "vipzfzz", e)
-- Visual
nvim_set_keymap("n", "vp", "vip", e)
nvim_set_keymap("n", "v.", ":0<CR>VG", e)
nvim_set_keymap("n", "v/", "G$n<C-v>N", e)
nvim_set_keymap("n", "v!", "gg<C-v>Gzt", e)
nvim_set_keymap("n", "v#", "m0gg<C-v>`0zb", e)
nvim_set_keymap("n", "v*", "m0G<C-v>`0zt", e)
nvim_set_keymap("n", "vv", "0v$", e)
-- Change
nvim_set_keymap("n", "cp", "cip", n)
nvim_set_keymap("n", "c.", "ggVGs", n)
nvim_set_keymap("n", "c#", [["0yiwVgg:s/<C-r>0//cg<left><left><left>]], n)
nvim_set_keymap("n", "c!", [["0yiw:%s/<C-r>0//cg<left><left><left>]], n)
nvim_set_keymap("n", "c*", [["0yiwVG:s/<C-r>0//cg<left><left><left>]], n)
nvim_set_keymap("v", "C", [["0y:%s/<C-r>0//cg<left><left><left>]], n)
-- Copy
nvim_set_keymap("n", "yp", "yip", n)
nvim_set_keymap("n", "yd", ':let @+ = expand("%")<cr>', n)
nvim_set_keymap("n", "y.", "m0ggVGy`0", n)

-- Other
nvim_set_keymap("n", "<Home>", ":1<CR>", n)
nvim_set_keymap("n", "<End>", ":$<CR>", n)
nvim_set_keymap("x", "<Home>", ":1<CR>", n)
nvim_set_keymap("x", "<End>", ":$<CR>", n)

nvim_set_keymap("x", "<leader>/", '"hy/<C-r>h<CR>', s)
nvim_set_keymap("x", "<leader>?", '"hy?<C-r>h<CR>', s)


nvim_set_keymap("i", "<A-n>", "<esc>", sn)
nvim_set_keymap("x", "<A-n>", "<esc>", sn)

nvim_set_keymap("n", "<leader>oh", ":CodeiumChat<cr>", sn)

vim.keymap.set("n", "<C-Up>",    ":resize +2<CR>")
vim.keymap.set("n", "<C-Down>",  ":resize -2<CR>")
vim.keymap.set("n", "<C-Left>",  ":vertical resize -5<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +5<CR>")

