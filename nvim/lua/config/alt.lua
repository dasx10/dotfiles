local fn = vim.fn
function ToUpRecursive()
    if fn.line(".") == 1 then
        vim.cmd("move $")
    else
        vim.cmd("move -2")
    end
end
function ToDownRecursive()
    if fn.line(".") == vim.fn.line("$") then
        vim.cmd("move 0")
    else
        vim.cmd("move +=1")
    end
end
local wo = vim.wo
function CheckboxRelative()
    wo.relativenumber = wo.relativenumber == false
end

local s = { silent = true }
local sn = { silent = true, noremap = true }
local snx = { silent = true, noremap = true, expr = true }
local n = { noremap = true }
local e = {}
local x = { expr = true }

nvim_set_keymap = vim.api.nvim_set_keymap;

nvim_set_keymap("n", "<A-k>", ":lua ToUpRecursive()<cr>==", sn)
nvim_set_keymap("n", "<A-j>", ":lua ToDownRecursive()<cr>==", sn)
nvim_set_keymap("n", "<A-g>", ":move 0<CR>==", sn)
nvim_set_keymap("n", "<A-l>", "m0I\t<esc>`0", sn)
nvim_set_keymap("n", "<A-S-l>", "m0I\t\t<esc>`0", sn)
nvim_set_keymap("n", "<A-h>", "m0^2dh`0", sn)
nvim_set_keymap("n", "<A-n>", "m0yyp`0j", sn)
nvim_set_keymap("n", "<A-p>", "m0yyP`0k", sn)
nvim_set_keymap("n", "<A-n>", ":move<space>", sn)

nvim_set_keymap("v", "<A-k>", ":move -2<cr>gv=gv", sn)
nvim_set_keymap("v", "<A-j>", ":move'>+<cr>gv=gv", sn)
nvim_set_keymap("v", "<A-h>", ":normal ^2dh<cr>gv", sn)
nvim_set_keymap("v", "<A-l>", ":normal I <cr>gv", sn)
nvim_set_keymap("v", "<A-n>", ":move<space>", sn)
nvim_set_keymap("v", "<A-g>", ":move 0<CR>gb", sn)
