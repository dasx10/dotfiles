return {
  "tpope/vim-commentary",
  config = function()
    local s = { silent = true }
    local sn = { silent = true, noremap = true }
    local e = {}
    nvim_set_keymap = vim.api.nvim_set_keymap
    -- CTRL MAP
    nvim_set_keymap("v", "<C-/>", ":Commentary<CR>gv=gv", sn)
    nvim_set_keymap("n", "<C-/>", ":Commentary<CR>==", s)
    nvim_set_keymap("i", "<C-/>", "<esc>:Commentary<cr>", s)

    -- TMUX FIX COMMENT
    nvim_set_keymap("v", "<C-_>", ":Commentary<CR>gv=gv", sn)
    nvim_set_keymap("n", "<C-_>", ":Commentary<CR>==", s)
    nvim_set_keymap("i", "<C-_>", "<esc>:Commentary<cr>a", s)

    nvim_set_keymap("n", "<leader>cc", ":Commentary<cr>", e)
    nvim_set_keymap("v", "<leader>cc", ":Commentary<cr>gv=gv", e)

    nvim_set_keymap("n", "<leader>cp", "m0vip=vip:Commentary<cr>`0", e)
    nvim_set_keymap("n", "<leader>c[", "m0vi[=vi[:Commentary<cr>`0", e)
    nvim_set_keymap("n", "<leader>c{", "m0vi{=vi{:Commentary<cr>`0", e)
    nvim_set_keymap("n", "<leader>c<", "m0vi<=vi<:Commentary<cr>`0", e)
    nvim_set_keymap("n", "<leader>c(", "m0vi(=vi(:Commentary<cr>`0", e)
    nvim_set_keymap("n", "<leader>c'", "m0vi'=vi':Commentary<cr>`0", e)
    nvim_set_keymap("n", '<leader>c"', 'm0vi"=vi":Commentary<cr>`0', e)
    nvim_set_keymap("n", "<leader>c`", "m0vi`=vi`:Commentary<cr>`0", e)

    nvim_set_keymap("n", "<leader>cap", "m0vap=vap:Commentary<cr>`0", e)
    nvim_set_keymap("n", "<leader>ca[", "m0va[=va[:Commentary<cr>`0", e)
    nvim_set_keymap("n", "<leader>ca{", "m0va{=va{:Commentary<cr>`0", e)
    nvim_set_keymap("n", "<leader>ca<", "m0va<=va<:Commentary<cr>`0", e)
    nvim_set_keymap("n", "<leader>ca(", "m0va(=va(:Commentary<cr>`0", e)
    nvim_set_keymap("n", "<leader>ca'", "m0va'=va':Commentary<cr>`0", e)
    nvim_set_keymap("n", '<leader>ca"', 'm0va"=va":Commentary<cr>`0', e)
    nvim_set_keymap("n", "<leader>ca`", "m0va`=va`:Commentary<cr>`0", e)

    nvim_set_keymap("n", "<leader>cip", "m0vip=vip:Commentary<cr>`0", sn)
    nvim_set_keymap("n", "<leader>ci[", "m0vi[=vi[:Commentary<cr>`0", sn)
    nvim_set_keymap("n", "<leader>ci{", "m0vi{=vi{:Commentary<cr>`0", sn)
    nvim_set_keymap("n", "<leader>ci<", "m0vi<=vi<:Commentary<cr>`0", sn)
    nvim_set_keymap("n", "<leader>ci(", "m0vi(=vi(:Commentary<cr>`0", sn)
    nvim_set_keymap("n", "<leader>ci'", "m0vi'=vi':Commentary<cr>`0", sn)
    nvim_set_keymap("n", '<leader>ci"', 'm0vi"=vi":Commentary<cr>`0', sn)
    nvim_set_keymap("n", "<leader>ci`", "m0vi`=vi`:Commentary<cr>`0", sn)
  end,
}
