require'nvim-treesitter.configs'.setup {
ensure_installed={
"html",
"json",
"json5",
"jsdoc",
"css",
"scss",
"javascript",
"typescript",
"tsx",
"vue",
"lua",
"vim",
"regex",
"sql"
},
sync_install=false,
auto_install=true,
ignore_install={},
highlight={
  enable=true,
  disable=function(lang, buf)
    local ok, stats=pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    if ok and stats and stats.size > 102400 then
      return true
    end
  end,
  additional_vim_regex_highlighting = false,
},
}
